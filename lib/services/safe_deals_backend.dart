import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SafeDealsBackend {
  SafeDealsBackend._();

  static final SafeDealsBackend instance = SafeDealsBackend._();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  User? get currentUser => auth.currentUser;

  String get uid {
    final user = currentUser;
    if (user == null) {
      throw StateError('Please sign in first.');
    }
    return user.uid;
  }

  // 1. Send mobile OTP
  Future<void> sendPhoneOtp({
    required String phoneNumber,
    required void Function(String verificationId, int? resendToken)
        codeSent,
    required void Function(FirebaseAuthException error) onError,
    void Function(PhoneAuthCredential credential)? onAutoVerified,
    int? forceResendingToken,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      forceResendingToken: forceResendingToken,
      verificationCompleted: (credential) {
        onAutoVerified?.call(credential);
      },
      verificationFailed: onError,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  // 2. Verify OTP and save basic user record
  Future<UserCredential> verifyPhoneOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final result = await auth.signInWithCredential(credential);
    final user = result.user;

    if (user != null) {
      await db.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'phoneNumber': user.phoneNumber,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }

    return result;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  // 3. Save user profile
  Future<void> saveProfile({
    required String name,
    String? city,
  }) async {
    await db.collection('users').doc(uid).set({
      'uid': uid,
      'name': name.trim(),
      if (city != null) 'city': city.trim(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchMyProfile() {
    return db.collection('users').doc(uid).snapshots();
  }

  // 4. Upload profile photo or selfie
  Future<String> uploadUserImage({
    required File file,
    required String type,
  }) async {
    if (type != 'selfies' && type != 'profile') {
      throw ArgumentError('type must be selfies or profile');
    }

    final ref = storage.ref(
      '$type/$uid/${DateTime.now().microsecondsSinceEpoch}.jpg',
    );

    await ref.putFile(
      file,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    return ref.getDownloadURL();
  }

  Future<void> saveSelfieRecord({
    required String imageUrl,
  }) async {
    await db.collection('users').doc(uid).set({
      'selfieImageUrl': imageUrl,
      'selfieStatus': 'submitted',
      'selfieSubmittedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // 5. Submit bank verification request.
  // Only last four account digits are stored here.
  // This does not independently verify bank ownership.
  Future<void> saveBankVerificationRequest({
    required String bankName,
    required String accountLast4,
    required String ifsc,
  }) async {
    final last4 = accountLast4.replaceAll(RegExp(r'\D'), '');
    final cleanIfsc = ifsc.trim().toUpperCase();

    if (last4.length != 4) {
      throw ArgumentError('Enter only the last 4 account digits.');
    }

    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(cleanIfsc)) {
      throw ArgumentError('Invalid IFSC format.');
    }

    await db.collection('bankVerificationRequests').doc(uid).set({
      'uid': uid,
      'bankName': bankName.trim(),
      'accountLast4': last4,
      'ifsc': cleanIfsc,
      'status': 'pending',
      'submittedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // 6. Upload a vehicle photo
  Future<String> uploadVehicleImage({
    required File file,
    required String listingId,
  }) async {
    final ref = storage.ref(
      'vehicles/$uid/$listingId/'
      '${DateTime.now().microsecondsSinceEpoch}.jpg',
    );

    await ref.putFile(
      file,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    return ref.getDownloadURL();
  }

  // 7. Create a vehicle listing
  Future<String> createVehicleListing({
    required String title,
    required String category,
    required String brand,
    required String model,
    required int year,
    required int price,
    required String city,
    required String description,
    required List<String> imageUrls,
    String? fuel,
    int? kilometres,
  }) async {
    final doc = db.collection('vehicles').doc();

    await doc.set({
      'id': doc.id,
      'sellerUid': uid,
      'title': title.trim(),
      'category': category,
      'brand': brand.trim(),
      'model': model.trim(),
      'year': year,
      'price': price,
      'city': city.trim(),
      'description': description.trim(),
      'imageUrls': imageUrls,
      if (fuel != null) 'fuel': fuel,
      if (kilometres != null) 'kilometres': kilometres,
      'status': 'pending_review',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return doc.id;
  }

  // 8. Watch approved vehicle listings
  Stream<QuerySnapshot<Map<String, dynamic>>> watchApprovedVehicles({
    String? category,
  }) {
    Query<Map<String, dynamic>> query = db
        .collection('vehicles')
        .where('status', isEqualTo: 'approved');

    if (category != null && category != 'All') {
      query = query.where('category', isEqualTo: category);
    }

    return query.orderBy('createdAt', descending: true).snapshots();
  }

  // 9. Watch current user's listings
  Stream<QuerySnapshot<Map<String, dynamic>>> watchMyListings() {
    return db
        .collection('vehicles')
        .where('sellerUid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // 10. Add or remove a favourite
  Future<void> setFavourite({
    required String vehicleId,
    required bool isFavourite,
  }) async {
    final ref = db
        .collection('users')
        .doc(uid)
        .collection('favourites')
        .doc(vehicleId);

    if (isFavourite) {
      await ref.set({
        'vehicleId': vehicleId,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } else {
      await ref.delete();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchFavourites() {
    return db
        .collection('users')
        .doc(uid)
        .collection('favourites')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // 11. Buyer-seller chat
  String conversationIdFor(String otherUid) {
    final participants = [uid, otherUid]..sort();
    return participants.join('_');
  }

  Future<void> sendMessage({
    required String otherUid,
    required String text,
  }) async {
    final clean = text.trim();

    if (clean.isEmpty) return;

    if (otherUid == uid) {
      throw ArgumentError('You cannot message yourself.');
    }

    final conversationId = conversationIdFor(otherUid);
    final conversation =
        db.collection('conversations').doc(conversationId);

    await conversation.set({
      'participants': ([uid, otherUid]..sort()),
      'lastMessage': clean,
      'lastMessageAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await conversation.collection('messages').add({
      'senderUid': uid,
      'text': clean,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchMessages(
    String otherUid,
  ) {
    return db
        .collection('conversations')
        .doc(conversationIdFor(otherUid))
        .collection('messages')
        .orderBy('createdAt')
        .snapshots();
  }
}
