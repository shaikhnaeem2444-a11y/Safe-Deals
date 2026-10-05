import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
void main() {
    runApp(const SafeDealsApp());
}

class SafeDealsApp extends StatelessWidget {
    const SafeDealsApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Safe-Deals',
            theme: ThemeData(
                primarySwatch: Colors.green,
            ),
            home: const TrustScreen(),
        );
    }
}

class TrustScreen extends StatelessWidget {
    const TrustScreen({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        const Icon(
                            Icons.verified_user,
                            size: 80,
                            color: Colors.green,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                            'Welcome to Safe-Deals',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                            'Aapka apna 100% secure aur trusted platform.',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        _buildTrustFeature(
                            Icons.lock_outline,
                            'Login se pehle Subscription',
                            'Security ke liye pehle subscription zaroori hai.',
                        ),
                        const SizedBox(height: 15),
                        _buildTrustFeature(
                            Icons.account_balance,
                            'Bank-Linked Number Only',
                            'Wahi mobile number chalega jo bank account se linked ho.',
                        ),
                        const SizedBox(height: 15),
                        _buildTrustFeature(
                            Icons.camera_alt_outlined,
                            'Real Live Selfie Profile',
                            'Koi fake photo nahi, sirf live selfie profile photo.',
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                    ),
                                ),
                                onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>  BankLinkingScreen(),
    ),
  );
},
                                child: const Text(
                                    'Aage Badhein (Continue)',
                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }

    Widget _buildTrustFeature(IconData icon, String title, String subtitle) {
        return Row(
            children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: Colors.green, size: 28),
                ),
                const SizedBox(width: 15),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                                title,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                ),
                            ),
                            const SizedBox(height: 2),
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
        );
    }
}
class BankLinkingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Account Linking"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Apna Bank Account Jodein",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Safe-Deals par secure payment ke liye apna bank details enter karein.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Account Number",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: "IFSC Code",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
            onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>  ProfileSelfieScreen(),
    ),
  );
},   
                
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: Text("Verify & Link Bank", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
class ProfileSelfieScreen extends StatefulWidget {
  const ProfileSelfieScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSelfieScreen> createState() => _ProfileSelfieScreenState();
}

class _ProfileSelfieScreenState extends State<ProfileSelfieScreen> {
  CameraController? _cameraController;
  bool _cameraReady = false;
  bool _photoTaken = false;

  @override
  void initState() {
    super.initState();
    _openCamera();
  }

  Future<void> _openCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        return;
      }

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      if (mounted) {
        setState(() {
          _cameraReady = true;
        });
      }
    } catch (e) {
      debugPrint("Camera error: $e");
    }
  }

  Future<void> _takeSelfie() async {
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      await _cameraController!.takePicture();

      if (mounted) {
        setState(() {
          _photoTaken = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Selfie successfully captured!"),
          ),
        );
      }
    } catch (e) {
      debugPrint("Selfie error: $e");
    }
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
        title: const Text("Profile Selfie Verification"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: _cameraReady
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CameraPreview(_cameraController!),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),

            const SizedBox(height: 15),

            Text(
              _photoTaken
                  ? "Selfie Successfully Captured"
                  : "Apni Live Selfie Capture Karein",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            Text(
              _photoTaken
                  ? "Aapki selfie capture ho gayi hai."
                  : "Account ko fully verify karne ke liye apni clear live selfie capture karein.",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: _cameraReady ? _takeSelfie : null,
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              label: Text(
                _photoTaken ? "Selfie Dobara Khinchein" : "Selfie Khinchein",
                style: const TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),

            const SizedBox(height: 15),

            OutlinedButton(
              onPressed: _photoTaken
                  ? () {
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text("Verification Complete Karein"),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
