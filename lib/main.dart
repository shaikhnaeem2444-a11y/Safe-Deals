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
              const SizedBox(height: 45),
              const Icon(
                Icons.verified_user,
                color: Colors.green,
                size: 90,
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
                'Aapka apna secure aur trusted vehicle platform.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 40),
              const Feature(
                Icons.lock_outline,
                'Login se pehle Subscription',
                'Security ke liye active subscription required hai.',
              ),
              const SizedBox(height: 18),
              const Feature(
                Icons.account_balance_outlined,
                'Bank-Linked Number Only',
                'Bank account se linked mobile number use karein.',
              ),
              const SizedBox(height: 18),
              const Feature(
                Icons.camera_alt_outlined,
                'Real Live Selfie Profile',
                'Verification ke liye live selfie required hai.',
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

  const Feature(
    this.icon,
    this.title,
    this.subtitle, {
    super.key,
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
                  fontSize: 18,
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
            ),
          ),
          const SizedBox(height: 30),
          const Benefit('Secure vehicle marketplace access'),
          const Benefit('Verified profile process'),
          const Benefit('Bank-linked mobile number process'),
          const Benefit('Vehicle-only platform'),
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

// ============================================================
// BENEFIT
// ============================================================

class Benefit extends StatelessWidget {
  final String text;

  const Benefit(
    this.text, {
    super.key,
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
              style: const TextStyle(
                fontSize: 16,
              ),
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
  final TextEditingController phoneController =
      TextEditingController();

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
          content: Text(
            'Valid 10-digit mobile number enter karein.',
          ),
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
          const SizedBox(height: 30),
          const Icon(
            Icons.phone_android,
            size: 80,
            color: Colors.green,
          ),
          const SizedBox(height: 20),
          const Text(
            'Mobile Number Login',
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
  State<BankLinkingScreen> createState() =>
      _BankLinkingScreenState();
}

class _BankLinkingScreenState
    extends State<BankLinkingScreen> {
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
          content: Text(
            'Valid bank account number enter karein.',
          ),
        ),
      );
      return;
    }

    if (ifsc.length < 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Valid 11-character IFSC Code enter karein.',
          ),
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
// REAL CAMERA SELFIE SCREEN
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

      _cameraController = controller;

      setState(() {
        _cameraReady = true;
        _cameraError = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _cameraError = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Camera open nahi ho paaya. Camera permission check karein.',
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
          const SnackBar(
            content: Text(
              'Selfie capture nahi ho paayi. Dobara try karein.',
            ),
          ),
        );
      }
    }
  }

  Future<void> _retakeSelfie() async {
    if (!mounted) {
      return;
    }

    setState(() {
      _photoTaken = false;
    });
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
                child: _cameraError
                    ? _cameraErrorView()
                    : _cameraReady
                        ? ClipRRect(
                            borderRadius:
                                BorderRadius.circular(18),
                            child: SizedBox(
                              width: double.infinity,
                              child: CameraPreview(
                                _cameraController!,
                              ),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
              ),
              const SizedBox(height: 16),
              Text(
                _photoTaken
                    ? 'Selfie Successfully Captured'
                    : 'Apni Live Selfie Capture Karein',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _photoTaken
                    ? 'Aapki selfie verification ke liye ready hai.'
                    : 'Account ko fully verify karne ke liye clear live selfie capture karein.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _cameraReady
                      ? (_photoTaken
                          ? _retakeSelfie
                          : _takeSelfie)
                      : null,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _cameraErrorView() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.camera_alt_outlined,
                size: 70,
                color: Colors.redAccent,
              ),
              SizedBox(height: 16),
              Text(
                'Camera available nahi hai.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Camera permission allow karke dobara try karein.',
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
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
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
                  size: 50,
                ),
                SizedBox(height: 12),
                Text(
                  'Welcome to Safe-Deals',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Aapka secure vehicle marketplace.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          HomeTile(
            icon: Icons.directions_car,
            title: 'Buy Vehicle',
            subtitle: 'Verified vehicles browse karein.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VehicleListScreen(),
                ),
              );
            },
          ),
          HomeTile(
            icon: Icons.add_circle_outline,
            title: 'Sell Vehicle',
            subtitle: 'Apni vehicle listing create karein.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SellVehicleScreen(),
                ),
              );
            },
          ),
          HomeTile(
            icon: Icons.person_outline,
            title: 'My Profile',
            subtitle: 'Profile aur verification details dekhein.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
          ),
          HomeTile(
            icon: Icons.security,
            title: 'Safe-Deals Verification',
            subtitle: 'Apna verification status dekhein.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VerificationScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOME TILE
// ============================================================

class HomeTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const HomeTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade50,
          child: Icon(
            icon,
            color: Colors.green,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 17,
        ),
        onTap: onTap,
      ),
    );
  }
}

// ============================================================
// VEHICLE LIST
// ============================================================

class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicles = [
      {
        'name': 'Hyundai Creta 2020',
        'type': 'Car',
        'price': '₹ 9,85,000',
        'details': 'Diesel • 45,000 KM',
      },
      {
        'name': 'Royal Enfield Classic 350',
        'type': 'Bike',
        'price': '₹ 1,45,000',
        'details': '2019 • 21,000 KM',
      },
      {
        'name': 'Mahindra 575 DI',
        'type': 'Tractor',
        'price': '₹ 5,20,000',
        'details': '2018 • 1800 HR',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Vehicle'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search vehicle...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Browse Vehicles',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          ...vehicles.map(
            (vehicle) => Card(
              margin: const EdgeInsets.only(bottom: 14),
              child: ListTile(
                contentPadding: const EdgeInsets.all(14),
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.green.shade50,
                  child: const Icon(
                    Icons.directions_car,
                    color: Colors.green,
                  ),
                ),
                title: Text(
                  vehicle['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${vehicle['type']} • ${vehicle['details']}',
                ),
                trailing: Text(
                  vehicle['price']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VehicleDetailsScreen(
                        name: vehicle['name']!,
                        type: vehicle['type']!,
                        price: vehicle['price']!,
                        details: vehicle['details']!,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// VEHICLE DETAILS
// ============================================================

class VehicleDetailsScreen extends StatelessWidget {
  final String name;
  final String type;
  final String price;
  final String details;

  const VehicleDetailsScreen({
    required this.name,
    required this.type,
    required this.price,
    required this.details,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Details'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 210,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.directions_car,
              size: 100,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 22),
          Text(
            name,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            type,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            details,
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            price,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Seller enquiry feature ready for next integration.',
                    ),
                  ),
                );
              },
              child: const Text(
                'Contact Seller',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
// SELL VEHICLE
// ============================================================

class SellVehicleScreen extends StatefulWidget {
  const SellVehicleScreen({super.key});

  @override
  State<SellVehicleScreen> createState() =>
      _SellVehicleScreenState();
}

class _SellVehicleScreenState
    extends State<SellVehicleScreen> {
  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController modelController =
      TextEditingController();

  final TextEditingController priceController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    modelController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _submitListing() {
    if (nameController.text.trim().isEmpty ||
        modelController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Vehicle ki complete details enter karein.',
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Vehicle listing successfully prepared.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageShell(
      title: 'Sell Vehicle',
      color: Colors.green,
      child: ListView(
        children: [
          const Text(
            'Apni Vehicle Sell Karein',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Vehicle Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: modelController,
            decoration: const InputDecoration(
              labelText: 'Model / Year',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Expected Price',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Vehicle photo selection next integration ke liye ready hai.',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.photo_camera),
            label: const Text('Vehicle Photos Add Karein'),
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: _submitListing,
              child: const Text(
                'Submit Vehicle Listing',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
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
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 48,
            backgroundColor: Colors.green,
            child: Icon(
              Icons.person,
              size: 55,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Safe-Deals User',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 25),
          const ProfileInfo(
            icon: Icons.phone,
            title: 'Mobile Verification',
            value: 'Verified',
          ),
          const ProfileInfo(
            icon: Icons.account_balance,
            title: 'Bank Verification',
            value: 'Completed',
          ),
          const ProfileInfo(
            icon: Icons.camera_alt,
            title: 'Selfie Verification',
            value: 'Completed',
          ),
          const ProfileInfo(
            icon: Icons.verified_user,
            title: 'Account Status',
            value: 'Verified',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE INFO
// ============================================================

class ProfileInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileInfo({
    required this.icon,
    required this.title,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green,
        ),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// VERIFICATION
// ============================================================

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safe-Deals Verification'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(
            Icons.verified,
            size: 90,
            color: Colors.green,
          ),
          const SizedBox(height: 18),
          const Center(
            child: Text(
              'Verification Complete',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30),
          const VerificationItem(
            title: 'Mobile Number',
            status: 'Verified',
          ),
          const VerificationItem(
            title: 'Bank Account',
            status: 'Verified',
          ),
          const VerificationItem(
            title: 'Live Selfie',
            status: 'Verified',
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'Aapka Safe-Deals verification process complete hai.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// VERIFICATION ITEM
// ============================================================

class VerificationItem extends StatelessWidget {
  final String title;
  final String status;

  const VerificationItem({
    required this.title,
    required this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          status,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE SELFIE PAGE SHELL
// ============================================================

class PageShell extends StatelessWidget {
  final String title;
  final Color color;
  final Widget child;

  const PageShell(
    this.title,
    this.color,
    this.child, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}
