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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.verified_user,
                  size: 60,
                  color: Colors.green.shade700,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Welcome to Safe-Deals',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Aapka apna secure vehicle marketplace.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 35),

              const FeatureTile(
                icon: Icons.lock_outline,
                title: 'Subscription Required',
                subtitle:
                    'Secure access ke liye subscription zaroori hai.',
              ),

              const SizedBox(height: 15),

              const FeatureTile(
                icon: Icons.account_balance_outlined,
                title: 'Bank-Linked Number',
                subtitle:
                    'Bank account se linked mobile number use karein.',
              ),

              const SizedBox(height: 15),

              const FeatureTile(
                icon: Icons.camera_alt_outlined,
                title: 'Live Selfie Profile',
                subtitle:
                    'Real user verification ke liye live selfie zaroori hai.',
              ),

              const SizedBox(height: 38),

              SizedBox(
                width: double.infinity,
                height: 54,
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
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Aage Badhein (Continue)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Text(
                'Safe-Deals • Vehicle Only',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
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
// FEATURE TILE
// ============================================================

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const FeatureTile({
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
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.green.shade700,
            size: 28,
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
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
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
// BANK LINKING SCREEN
// ============================================================

class BankLinkingScreen extends StatefulWidget {
  const BankLinkingScreen({super.key});

  @override
  State<BankLinkingScreen> createState() => _BankLinkingScreenState();
}

class _BankLinkingScreenState extends State<BankLinkingScreen> {
  final TextEditingController accountController =
      TextEditingController();

  final TextEditingController ifscController =
      TextEditingController();

  final TextEditingController mobileController =
      TextEditingController();

  @override
  void dispose() {
    accountController.dispose();
    ifscController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  void _verifyAndContinue() {
    final account = accountController.text.trim();
    final ifsc = ifscController.text.trim();
    final mobile = mobileController.text.trim();

    if (account.isEmpty || ifsc.isEmpty || mobile.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please sabhi details fill karein.'),
        ),
      );
      return;
    }

    if (account.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account number sahi enter karein.'),
        ),
      );
      return;
    }

    if (ifsc.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('IFSC code sahi enter karein.'),
        ),
      );
      return;
    }

    if (mobile.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mobile number sahi enter karein.'),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Account Linking'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Apna Bank Account Jodein',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Secure verification ke liye apni details enter karein.',
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 25),

            TextField(
              controller: accountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Account Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.account_balance),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: ifscController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: 'IFSC Code',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.code),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Bank-Linked Mobile Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _verifyAndContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Verify & Link Bank',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE SELFIE SCREEN
// ============================================================

class ProfileSelfieScreen extends StatefulWidget {
  const ProfileSelfieScreen({super.key});

  @override
  State<ProfileSelfieScreen> createState() =>
      _ProfileSelfieScreenState();
}

class _ProfileSelfieScreenState extends State<ProfileSelfieScreen> {
  CameraController? _cameraController;

  bool _cameraReady = false;
  bool _photoTaken = false;
  bool _openingCamera = true;

  @override
  void initState() {
    super.initState();
    _openCamera();
  }

  Future<void> _openCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        if (mounted) {
          setState(() {
            _openingCamera = false;
            _cameraReady = false;
          });
        }
        return;
      }

      CameraDescription selectedCamera = cameras.first;

      for (final camera in cameras) {
        if (camera.lensDirection == CameraLensDirection.front) {
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

      _cameraController = controller;

      setState(() {
        _cameraReady = true;
        _openingCamera = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _cameraReady = false;
          _openingCamera = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Camera open nahi ho saka: $e',
            ),
          ),
        );
      }
    }
  }

  Future<void> _takeSelfie() async {
    final controller = _cameraController;

    if (controller == null ||
        !controller.value.isInitialized) {
      return;
    }

    if (controller.value.isTakingPicture) {
      return;
    }

    try {
      await controller.takePicture();

      if (!mounted) {
        return;
      }

      setState(() {
        _photoTaken = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selfie successfully captured!',
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Selfie capture failed: $e',
            ),
          ),
        );
      }
    }
  }

  void _completeVerification() {
    if (!_photoTaken) {
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
        builder: (_) => const HomeScreen(),
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
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: _cameraReady &&
                          _cameraController != null
                      ? CameraPreview(
                          _cameraController!,
                        )
                      : Center(
                          child: _openingCamera
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    'Camera available nahi hai.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                        ),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                _photoTaken
                    ? 'Selfie Successfully Captured'
                    : 'Apni Live Selfie Capture Karein',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                _photoTaken
                    ? 'Aapki selfie verification ke liye ready hai.'
                    : 'Clear front-camera selfie capture karein.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed:
                      _cameraReady ? _takeSelfie : null,
                  icon: const Icon(
                    Icons.camera_alt,
                  ),
                  label: Text(
                    _photoTaken
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
                  onPressed: _photoTaken
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

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Safe-Deals',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.verified_user,
                    size: 48,
                    color: Colors.green.shade700,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Welcome to Safe-Deals',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Verified vehicle marketplace',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Vehicle Services',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            )
