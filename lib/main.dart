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
      title: 'Safe Deals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

// ============================================================
// WELCOME
// ============================================================

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              const Icon(
                Icons.verified_user,
                size: 85,
                color: Colors.red,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to Safe Deals',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Aapka secure aur trusted vehicle marketplace.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 35),

              const TrustFeature(
                icon: Icons.lock_outline,
                title: 'Secure Platform',
                subtitle: 'Safe aur trusted vehicle transactions.',
              ),

              const SizedBox(height: 14),

              const TrustFeature(
                icon: Icons.account_balance,
                title: 'Bank Verification',
                subtitle: 'Secure verification ke liye bank details.',
              ),

              const SizedBox(height: 14),

              const TrustFeature(
                icon: Icons.camera_alt_outlined,
                title: 'Live Selfie Verification',
                subtitle: 'Profile verification ke liye live selfie.',
              ),

              const SizedBox(height: 40),

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
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }
}

class TrustFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const TrustFeature({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.green,
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
              const SizedBox(height: 3),
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
// BANK LINKING
// ============================================================

class BankLinkingScreen extends StatefulWidget {
  const BankLinkingScreen({super.key});

  @override
  State<BankLinkingScreen> createState() => _BankLinkingScreenState();
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

  void _continue() {
    final account = accountController.text.trim();
    final ifsc = ifscController.text.trim();

    if (account.isEmpty || ifsc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account Number aur IFSC Code enter karein.'),
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
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Apna Bank Account Jodein',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Safe Deals par secure verification ke liye bank details enter karein.',
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 28),

              TextField(
                controller: accountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Account Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_balance),
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller: ifscController,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'IFSC Code',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.code),
                ),
              ),

              const Spacer(),

              SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Verify & Continue',
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
      ),
    );
  }
}

// ============================================================
// SELFIE VERIFICATION
// ============================================================

class ProfileSelfieScreen extends StatefulWidget {
  const ProfileSelfieScreen({super.key});

  @override
  State<ProfileSelfieScreen> createState() => _ProfileSelfieScreenState();
}

class _ProfileSelfieScreenState extends State<ProfileSelfieScreen> {
  CameraController? _cameraController;

  bool _cameraReady = false;
  bool _photoTaken = false;
  bool _cameraError = false;

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
            _cameraError = true;
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
        _cameraError = false;
      });
    } catch (e) {
      debugPrint('Camera error: $e');

      if (mounted) {
        setState(() {
          _cameraError = true;
        });
      }
    }
  }

  Future<void> _takeSelfie() async {
    final controller = _cameraController;

    if (controller == null || !controller.value.isInitialized) {
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
          content: Text('Selfie successfully captured!'),
        ),
      );
    } catch (e) {
      debugPrint('Selfie error: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Selfie capture nahi ho saki. Dobara try karein.'),
          ),
        );
      }
    }
  }

  void _completeVerification() {
    if (!_photoTaken) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pehle selfie capture karein.'),
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
                child: _cameraError
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera_alt_outlined,
                              size: 70,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'Camera open nahi ho saka.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _cameraError = false;
                                });
                                _openCamera();
                              },
                              child: const Text('Dobara Try Karein'),
                            ),
                          ],
                        ),
                      )
                    : _cameraReady && _cameraController != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: CameraPreview(
                              _cameraController!,
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
              ),

              const SizedBox(height: 15),

              Text(
                _photoTaken
                    ? 'Selfie Successfully Captured ✓'
                    : 'Apni Live Selfie Capture Karein',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: _photoTaken ? Colors.green : Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                _photoTaken
                    ? 'Aapki selfie verification ke liye ready hai.'
                    : 'Clear live selfie capture karein.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _cameraReady ? _takeSelfie : null,
                  icon: const Icon(Icons.camera_alt),
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
                  onPressed: _completeVerification,
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
// HOME
// ============================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Safe-Deals',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.verified_user,
                      color: Colors.green,
                      size: 48,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Welcome to Safe-Deals',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Verified vehicle marketplace',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                'What would you like to do?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: _HomeCard(
                      icon: Icons.directions_car,
                      title: 'Buy Vehicle',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const VehicleCategoryScreen(
                              mode: 'buy',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _HomeCard(
                      icon: Icons.sell,
                      title: 'Sell Vehicle',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const VehicleCategoryScreen(
                              mode: 'sell',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              _HomeCard(
                icon: Icons.person_outline,
                title: 'My Profile',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProfileScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 14),

              _HomeCard(
                icon: Icons.verified,
                title: 'Safe-Deals Verification',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const VerificationStatusScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 14),

              _HomeCard(
                icon: Icons.chat,
                title: 'Chat & Offers',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ChatScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _HomeCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green.shade50,
                child: Icon(
                  icon,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// VEHICLE CATEGORIES
// ============================================================

class VehicleCategoryScreen extends StatelessWidget {
  final String mode;

  const VehicleCategoryScreen({
    super.key,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final isSell = mode == 'sell';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isSell ? 'Sell Vehicle' : 'Buy Vehicle',
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isSell
                    ? 'Vehicle Type Chunein'
                    : 'Vehicle Search Karein',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              _categoryButton(
                context,
                Icons.two_wheeler,
                '2-Wheeler (Bike / Scooty)',
                isSell,
              ),

              const SizedBox(height: 14),

              _categoryButton(
                context,
                Icons.directions_car,
                '4-Wheeler (Car / Jeep)',
                isSell,
              ),

              const SizedBox(height: 14),

              _categoryButton(
                context,
                Icons.local_shipping,
                'Commercial / Heavy Vehicle',
                isSell,
              ),

              const SizedBox(height: 14),

              _categoryButton(
                context,
                Icons.agriculture,
                'Tractor / Agricultural',
                isSell,
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ChatScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.chat),
                label: const Text('Chat & Offers'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryButton(
    BuildContext context,
    IconData icon,
    String title,
    bool isSell,
  ) {
    return SizedBox(
      height: 55,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VehicleFormScreen(
                categoryTitle: title,
                isSell: isSell,
              ),
            ),
          );
        },
        icon: Icon(icon),
        label: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// VEHICLE FORM
// ============================================================

class VehicleFormScreen extends StatefulWidget {
  final String categoryTitle;
  final bool isSell;

  const VehicleFormScreen({
    super.key,
    required this.categoryTitle,
    required this.isSell,
  });

  @override
  State<VehicleFormScreen> createState() => _VehicleFormScreenState();
}

class _VehicleFormScreenState extends State<VehicleFormScreen> {
  final modelController = TextEditingController();
  final priceController = TextEditingController();
  final kmController = TextEditingController();
  final colourController = TextEditingController();
  final fuelController = TextEditingController();

  @override
  void dispose() {
    modelController.dispose();
    priceController.dispose();
    kmController.dispose();
    colourController.dispose();
    fuelController.dispose();
    super.dispose();
  }

  void _submit() {
    if (modelController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Model aur Price enter karein.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.isSell
              ? 'Vehicle listing ready hai.'
              : 'Vehicle search ready hai.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryTitle),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.isSell
                    ? 'Vehicle ki details bharein'
                    : 'Vehicle details search karein',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              _field(
                controller: modelController,
                label: 'Model',
              ),

              _field(
                controller: priceController,
                label: 'Price (₹)',
                keyboardType: TextInputType.number,
              ),

              _field(
                controller: kmController,
                label: 'Kilometers Driven',
                keyboardType: TextInputType.number,
              ),

              _field(
                controller: colourController,
                label: 'Colour',
              ),

              _field(
                controller: fuelController,
                label: 'Fuel Type',
              ),

              const SizedBox(height: 15),

              SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    widget.isSell
                        ? 'Ad Live Karein'
                        : 'Vehicle Search Karein',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE
// ============================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const CircleAvatar(
            radius: 48,
            child: Icon(
              Icons.person,
              size: 55,
            ),
          ),

          const SizedBox(height: 18),

          const Center(
            child: Text(
              'Safe Deals User',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 25),

          Card(
            child: ListTile(
              leading: const Icon(
                Icons.verified,
                color: Colors.green,
              ),
              title: const Text('Selfie Verification'),
              subtitle: const Text('Completed'),
              trailing: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text('Bank Verification'),
              subtitle: const Text('Verified'),
              trailing: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Safe Deals Account'),
              subtitle: const Text('Secure profile'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// VERIFICATION STATUS
// ============================================================

class VerificationStatusScreen extends StatelessWidget {
  const VerificationStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Status'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(
              Icons.verified,
              color: Colors.green,
              size: 90,
            ),
            const SizedBox(height: 20),
            const Text(
              'Verification Complete',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Aapki Safe Deals profile verification complete hai.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 30),
            const ListTile(
              leading: Icon(
                Icons.account_balance,
                color: Colors.green,
              ),
              title: Text('Bank Verification'),
              trailing: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.camera_alt,
                color: Colors.green,
              ),
              title: Text('Selfie Verification'),
              trailing: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CHAT
// ============================================================

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();

  final List<String> messages = [
    'Bhai, kya yeh price thoda kam ho sakta hai?',
    'Theek hai, final deal batao.',
  ];

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = messageController.text.trim();

    if (message.isEmpty) {
      return;
    }

    setState(() {
      messages.add(message);
    });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat & Offers'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final mine = index >= 2;

                return Align(
                  alignment: mine
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: mine
                          ? Colors.teal.shade100
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(messages[index]),
                  ),
                );
              },
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Message ya offer likhein...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
