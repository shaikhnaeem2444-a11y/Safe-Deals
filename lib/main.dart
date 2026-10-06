import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const SafeDealsApp());
}

class SafeDealsApp extends StatelessWidget {
  const SafeDealsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safe-Deals',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF8FAF8),
      ),
      home: const TrustScreen(),
    );
  }
}

// ============================================================
// APP DATA
// ============================================================

class VehicleListing {
  final String type;
  final String brand;
  final String model;
  final String year;
  final String price;
  final String city;
  final String description;
  final List<String> photos;

  VehicleListing({
    required this.type,
    required this.brand,
    required this.model,
    required this.year,
    required this.price,
    required this.city,
    required this.description,
    required this.photos,
  });
}

final List<VehicleListing> vehicleListings = [];

// ============================================================
// COMMON UI
// ============================================================

InputDecoration fieldDecoration(
  String label, {
  IconData? icon,
}) {
  return InputDecoration(
    labelText: label,
    prefixIcon: icon == null ? null : Icon(icon),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    filled: true,
    fillColor: Colors.white,
  );
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

// ============================================================
// WELCOME
// ============================================================

class TrustScreen extends StatelessWidget {
  const TrustScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 25),

              const Icon(
                Icons.verified_user,
                size: 85,
                color: Colors.green,
              ),

              const SizedBox(height: 18),

              const Text(
                'Welcome to Safe-Deals',
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              const Text(
                'Aapka apna secure aur trusted vehicle marketplace.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 35),

              _feature(
                Icons.lock_outline,
                'Secure Platform',
                'Safe aur trusted vehicle transactions ke liye.',
              ),

              _feature(
                Icons.account_balance,
                'Bank-Linked Account',
                'Account verification ke liye bank details.',
              ),

              _feature(
                Icons.camera_alt_outlined,
                'Live Selfie',
                'Real user profile verification.',
              ),

              _feature(
                Icons.directions_car,
                'Vehicles Only',
                'Sirf vehicles ki buying aur selling.',
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BankLinkingScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Aage Badhein (Continue)',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _feature(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.green.withOpacity(.15),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green.withOpacity(.10),
            child: Icon(
              icon,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// BANK LINKING
// ============================================================

class BankLinkingScreen extends StatefulWidget {
  const BankLinkingScreen({super.key});

  @override
  State<BankLinkingScreen> createState() =>
      _BankLinkingScreenState();
}

class _BankLinkingScreenState
    extends State<BankLinkingScreen> {
  final accountController = TextEditingController();
  final ifscController = TextEditingController();

  @override
  void dispose() {
    accountController.dispose();
    ifscController.dispose();
    super.dispose();
  }

  void continueToSelfie() {
    final account = accountController.text.trim();
    final ifsc = ifscController.text.trim().toUpperCase();

    if (!RegExp(r'^[0-9]{9,18}$').hasMatch(account)) {
      showMessage(
        context,
        'Valid Account Number enter karein.',
      );
      return;
    }

    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(ifsc)) {
      showMessage(
        context,
        'Valid 11-character IFSC Code enter karein.',
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileSelfieScreen(
          accountNumber: account,
          ifscCode: ifsc,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Account Linking'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Apna Bank Account Jodein',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Safe-Deals verification ke liye apni bank details enter karein.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 25),

              TextField(
                controller: accountController,
                keyboardType: TextInputType.number,
                maxLength: 18,
                decoration: fieldDecoration(
                  'Account Number',
                  icon: Icons.account_balance,
                ).copyWith(counterText: ''),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: ifscController,
                textCapitalization:
                    TextCapitalization.characters,
                maxLength: 11,
                decoration: fieldDecoration(
                  'IFSC Code',
                  icon: Icons.code,
                ).copyWith(counterText: ''),
              ),

              const SizedBox(height: 25),

              SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: continueToSelfie,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Verify & Continue',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Note: Real bank ownership verification ke liye secure bank-verification API/backend required hoga.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SELFIE
// ============================================================

class ProfileSelfieScreen extends StatefulWidget {
  final String accountNumber;
  final String ifscCode;

  const ProfileSelfieScreen({
    super.key,
    required this.accountNumber,
    required this.ifscCode,
  });

  @override
  State<ProfileSelfieScreen> createState() =>
      _ProfileSelfieScreenState();
}

class _ProfileSelfieScreenState
    extends State<ProfileSelfieScreen> {
  CameraController? controller;
  bool cameraReady = false;
  bool photoTaken = false;
  bool cameraError = false;

  @override
  void initState() {
    super.initState();
    openCamera();
  }

  Future<void> openCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        setState(() {
          cameraError = true;
        });
        return;
      }

      final front = cameras.where(
        (camera) =>
            camera.lensDirection ==
            CameraLensDirection.front,
      );

      final selected =
          front.isNotEmpty ? front.first : cameras.first;

      controller = CameraController(
        selected,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await controller!.initialize();

      if (!mounted) return;

      setState(() {
        cameraReady = true;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        cameraError = true;
      });
    }
  }

  Future<void> takeSelfie() async {
    if (controller == null ||
        !controller!.value.isInitialized) {
      return;
    }

    try {
      await controller!.takePicture();

      if (!mounted) return;

      setState(() {
        photoTaken = true;
      });

      showMessage(
        context,
        'Selfie successfully captured!',
      );
    } catch (_) {
      showMessage(
        context,
        'Selfie capture nahi ho saka.',
      );
    }
  }

  void completeVerification() {
    if (!photoTaken) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => VerificationSuccessScreen(
          accountNumber: widget.accountNumber,
          ifscCode: widget.ifscCode,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Selfie Verification'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: cameraError
                    ? const Center(
                        child: Text(
                          'Camera open nahi ho saka.',
                          style: TextStyle(fontSize: 17),
                        ),
                      )
                    : !cameraReady
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ClipRRect(
                            borderRadius:
                                BorderRadius.circular(18),
                            child:
                                CameraPreview(controller!),
                          ),
              ),

              const SizedBox(height: 15),

              Text(
                photoTaken
                    ? 'Selfie Successfully Captured'
                    : 'Apni Live Selfie Capture Karein',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                photoTaken
                    ? 'Aapki selfie capture ho gayi hai.'
                    : 'Clear live selfie capture karein.',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed:
                      cameraReady ? takeSelfie : null,
                  icon: const Icon(Icons.camera_alt),
                  label: Text(
                    photoTaken
                        ? 'Selfie Dobara Khinchein'
                        : 'Selfie Khinchein',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed:
                      photoTaken ? completeVerification : null,
                  child: const Text(
                    'Verification Complete Karein',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// VERIFICATION SUCCESS
// ============================================================

class VerificationSuccessScreen extends StatelessWidget {
  final String accountNumber;
  final String ifscCode;

  const VerificationSuccessScreen({
    super.key,
    required this.accountNumber,
    required this.ifscCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 105,
              ),

              const SizedBox(height: 20),

              const Text(
                'Verification Complete!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              const Text(
                'Aapka verification flow successfully complete ho gaya.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.08),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      'Account: •••• ${accountNumber.substring(accountNumber.length - 4)}',
                    ),
                    const SizedBox(height: 8),
                    Text('IFSC: $ifscCode'),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                      (_) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Safe-Deals Start Karein',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HOME
// ============================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safe-Deals'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(18),
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        children: [
          _homeCard(
            context,
            Icons.add_circle,
            'Sell Vehicle',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddVehicleScreen(),
                ),
              );
            },
          ),

          _homeCard(
            context,
            Icons.search,
            'Browse Vehicles',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BrowseVehiclesScreen(),
                ),
           
