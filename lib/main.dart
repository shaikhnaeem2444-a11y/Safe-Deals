import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
      ),
      home: const WelcomeScreen(),
    );
  }
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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 35),
              const Icon(
                Icons.verified_user,
                size: 90,
                color: Colors.green,
              ),
              const SizedBox(height: 24),
              const Text(
                'Welcome to Safe-Deals',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Aapka apna secure aur trusted vehicle marketplace.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 35),
              const Feature(
                icon: Icons.lock_outline,
                title: 'Login se pehle Subscription',
                subtitle: 'Security ke liye subscription zaroori hai.',
              ),
              const SizedBox(height: 18),
              const Feature(
                icon: Icons.account_balance_outlined,
                title: 'Bank-Linked Number Only',
                subtitle: 'Bank account se linked mobile number use karein.',
              ),
              const SizedBox(height: 18),
              const Feature(
                icon: Icons.camera_alt_outlined,
                title: 'Real Live Selfie Profile',
                subtitle: 'Verification ke liye live selfie capture karein.',
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SubscriptionScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Aage Badhein (Continue)',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
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
// FEATURE
// ============================================================

class Feature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const Feature({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: Colors.green,
            size: 30,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// SUBSCRIPTION
// ============================================================

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      title: 'Subscription',
      color: Colors.green,
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Icon(
            Icons.workspace_premium,
            size: 85,
            color: Colors.green,
          ),
          const SizedBox(height: 20),
          const Text(
            'Safe-Deals Subscription',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Safe-Deals use karne ke liye active subscription required hai.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 30),
          const Benefit(text: 'Secure vehicle marketplace access'),
          const Benefit(text: 'Verified profile process'),
          const Benefit(text: 'Bank-linked mobile number process'),
          const Benefit(text: 'Vehicle-only platform'),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
              child: const Text(
                'Continue to Login',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Benefit extends StatelessWidget {
  final String text;

  const Benefit({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// LOGIN
// ============================================================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void _continue() {
    final phone = phoneController.text.trim();

    if (phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Valid 10-digit mobile number enter karein.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const BankLinkingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageShell(
      title: 'Login',
      color: Colors.green,
      child: Column(
        children: [
          const SizedBox(height: 25),
          const Icon(
            Icons.phone_android,
            size: 80,
            color: Colors.green,
          ),
          const SizedBox(height: 20),
          const Text(
            'Mobile Number Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Bank account se linked mobile number enter karein.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 28),
          TextField(
            controller: phoneController,
            maxLength: 10,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Mobile Number',
              prefixText: '+91 ',
              border: OutlineInputBorder(),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _continue,
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
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
  State<BankLinkingScreen> createState() => _BankLinkingState();
}

class _BankLinkingState extends State<BankLinkingScreen> {
  final TextEditingController accountController =
      TextEditingController();

  final TextEditingController ifscController =
      TextEditingController();

  @override
  void dispose() {
    accountController.dispose();
    ifscController.dispose();
    super.dispose();
  }

  void _verifyBank() {
    final account = accountController.text.trim();
    final ifsc = ifscController.text.trim();

    if (account.isEmpty || ifsc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Account Number aur IFSC Code enter karein.',
          ),
        ),
      );
      return;
    }

    if (account.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Valid Account Number enter karein.'),
        ),
      );
      return;
    }

    if (ifsc.length < 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Valid IFSC Code enter karein.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfileSelfieScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageShell(
      title: 'Bank Account Linking',
      color: Colors.blueAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 15),
          const Text(
            'Apna Bank Account Jodein',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Safe-Deals par secure verification ke liye bank details enter karein.',
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 28),
          TextField(
            controller: accountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Account Number',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: ifscController,
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(
              labelText: 'IFSC Code',
              border: OutlineInputBorder(),
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: _verifyBank,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Verify & Link Bank',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SELFIE CAMERA
// ============================================================

class ProfileSelfieScreen extends StatefulWidget {
  const ProfileSelfieScreen({super.key});

  @override
  State<ProfileSelfieScreen> createState() =>
      _ProfileSelfieScreenState();
}

class _ProfileSelfieScreenState
    extends State<ProfileSelfieScreen> {
  CameraController? _cameraController;

  XFile? _selfieFile;

  bool _cameraReady = false;
  bool _cameraError = false;
  bool _capturing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        if (mounted) {
          setState(() {
            _cameraError = true;
          });
        }
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

      setState(() {
        _cameraController = controller;
        _cameraReady = true;
        _cameraError = false;
      });
    } catch (e) {
      debugPrint('Camera initialization error: $e');

      if (mounted) {
        setState(() {
          _cameraError = true;
        });
      }
    }
  }

  Future<void> _captureSelfie() async {
    final controller = _cameraController;

    if (controller == null ||
        !controller.value.isInitialized ||
        _capturing) {
      return;
    }

    setState(() {
      _capturing = true;
    });

    try {
      final file = await controller.takePicture();

      if (!mounted) {
        return;
      }

      setState(() {
        _selfieFile = file;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selfie successfully captured!',
          ),
        ),
      );
    } catch (e) {
      debugPrint('Selfie capture error: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Selfie capture nahi ho saki. Dobara try karein.',
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _capturing = false;
        });
      }
    }
  }

  void _completeVerification() {
    if (_selfieFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Pehle selfie capture karein.',
          ),
        ),
      );
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const VerificationSuccessScreen(),
      ),
      (route) => false,
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Selfie Verification',
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: _buildCameraArea(),
              ),
              const SizedBox(height: 15),
              Text(
                _selfieFile == null
                    ? 'Apni Live Selfie Capture Karein'
                    : 'Selfie Successfully Captured',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: _selfieFile == null
                      ? Colors.black87
                      : Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _selfieFile == null
                    ? 'Clear face ke saath live selfie capture karein.'
                    : 'Aapki selfie verification ke liye ready hai.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed:
                      _cameraReady && !_capturing
                          ? _captureSelfie
                          : null,
                  icon: const Icon(Icons.camera_alt),
                  label: Text(
                    _selfieFile == null
                        ? 'Selfie Khinchein'
                        : 'Selfie Dobara Khinchein',
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
                      _selfieFile != null
                          ? _completeVerification
                          : null,
                  child: const Text(
                    'Verification Complete Karein',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraArea() {
    if (_cameraError) {
      return 
