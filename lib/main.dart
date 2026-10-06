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
      home: const WelcomeScreen(),
    );
  }
}

// ============================================================
// DATA MODEL
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
// COMMON HELPERS
// ============================================================

InputDecoration inputDecoration(
  String label, {
  IconData? icon,
}) {
  return InputDecoration(
    labelText: label,
    prefixIcon: icon == null ? null : Icon(icon),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

// ============================================================
// WELCOME SCREEN
// ============================================================

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              const SizedBox(height: 28),

              const Icon(
                Icons.verified_user,
                color: Colors.green,
                size: 82,
              ),

              const SizedBox(height: 18),

              const Text(
                'Welcome to Safe-Deals',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Aapka apna secure aur trusted vehicle platform.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 35),

              _feature(
                Icons.lock_outline,
                'Login se pehle Subscription',
                'Security ke liye subscription zaroori hai.',
              ),

              _feature(
                Icons.account_balance,
                'Bank-Linked Number Only',
                'Bank account se linked number ka use karein.',
              ),

              _feature(
                Icons.camera_alt_outlined,
                'Real Live Selfie Profile',
                'Fake photo nahi, live selfie verification.',
              ),

              _feature(
                Icons.directions_car,
                'Vehicles Only',
                'Safe-Deals par sirf vehicles allowed hain.',
              ),

              const SizedBox(height: 30),

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
          color: Colors.green.withOpacity(0.12),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10),
            ),
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
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

class _BankLinkingScreenState extends State<BankLinkingScreen> {
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
        builder: (_) => SelfieScreen(
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
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Safe-Deals par secure payment ke liye apna bank details enter karein.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              TextField(
                controller: accountController,
                keyboardType: TextInputType.number,
                maxLength: 18,
                decoration: inputDecoration(
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
                decoration: inputDecoration(
                  'IFSC Code',
                  icon: Icons.code,
                ).copyWith(counterText: ''),
              ),

              const SizedBox(height: 24),

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
                'Real bank ownership verification ke liye secure bank API/backend required hoga.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
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
// SELFIE
// ============================================================

class SelfieScreen extends StatefulWidget {
  final String accountNumber;
  final String ifscCode;

  const SelfieScreen({
    super.key,
    required this.accountNumber,
    required this.ifscCode,
  });

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  CameraController? cameraController;

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
        if (!mounted) return;

        setState(() {
          cameraError = true;
        });
        return;
      }

      CameraDescription selectedCamera = cameras.first;

      for (final camera in cameras) {
        if (camera.lensDirection ==
            CameraLensDirection.front) {
          selectedCamera = camera;
          break;
        }
      }

      final controller = CameraController(
        selectedCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await controller.initialize();

      if (!mounted) {
        await controller.dispose();
        return;
      }

      cameraController = controller;

      setState(() {
        cameraReady = true;
        cameraError = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        cameraError = true;
      });

      debugPrint('Camera error: $e');
    }
  }

  Future<void> takeSelfie() async {
    final controller = cameraController;

    if (controller == null ||
        !controller.value.isInitialized) {
      return;
    }

    try {
      await controller.takePicture();

      if (!mounted) return;

      setState(() {
        photoTaken = true;
      });

      showMessage(
        context,
        'Selfie successfully captured.',
      );
    } catch (e) {
      showMessage(
        context,
        'Selfie capture nahi ho saka.',
      );
    }
  }

  void retakeSelfie() {
    setState(() {
      photoTaken = false;
    });
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
    cameraController?.dispose();
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
                child: _cameraView(),
              ),

              const SizedBox(height: 14),

              Text(
                photoTaken
                    ? 'Selfie Successfully Captured'
                    : 'Apni Live Selfie Capture Karein',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                photoTaken
                    ? 'Aapki selfie capture ho gayi hai.'
                    : 'Account verification ke liye clear live selfie capture karein.',
                textAlign: TextAlign.center,
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
                      cameraReady
                          ? (photoTaken
                              ? retakeSelfie
                              : takeSelfie)
                          : null,
                  icon: const Icon(Icons.camera_alt),
                  label: Text(
                    photoTaken
                        ? 'Selfie Dobara Khinchein'
                        : 'Selfie Khinchein',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white
