import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 30),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green.shade50,
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
                'Aapka secure vehicle marketplace.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 30),
              const InfoTile(
                Icons.lock_outline,
                'Subscription Required',
                'Secure access ke liye subscription zaroori hai.',
              ),
              const SizedBox(height: 12),
              const InfoTile(
                Icons.account_balance_outlined,
                'Bank-Linked Number',
                'Bank se linked mobile number use karein.',
              ),
              const SizedBox(height: 12),
              const InfoTile(
                Icons.camera_alt_outlined,
                'Live Selfie Profile',
                'Real user verification ke liye selfie.',
              ),
              const SizedBox(height: 30),
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

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const InfoTile(
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
        CircleAvatar(
          backgroundColor: Colors.green.shade50,
          child: Icon(
            icon,
            color: Colors.green.shade700,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
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

class BankLinkingScreen extends StatefulWidget {
  const BankLinkingScreen({super.key});

  @override
  State<BankLinkingScreen> createState() => _BankLinkingScreenState();
}

class _BankLinkingScreenState extends State<BankLinkingScreen> {
  final account = TextEditingController();
  final ifsc = TextEditingController();
  final mobile = TextEditingController();

  @override
  void dispose() {
    account.dispose();
    ifsc.dispose();
    mobile.dispose();
    super.dispose();
  }

  void verify() {
    if (account.text.trim().isEmpty ||
        ifsc.text.trim().isEmpty ||
        mobile.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please sabhi details fill karein.'),
        ),
      );
      return;
    }

    if (mobile.text.trim().length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Valid mobile number enter karein.'),
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
      body: ListView(
        padding: const EdgeInsets.all(20),
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
            'Secure verification ke liye details enter karein.',
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: account,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Account Number',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.account_balance),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: ifsc,
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(
              labelText: 'IFSC Code',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.code),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: mobile,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Bank-Linked Mobile Number',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: verify,
              child: const Text('Verify & Link Bank'),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileSelfieScreen extends StatefulWidget {
  const ProfileSelfieScreen({super.key});

  @override
  State<ProfileSelfieScreen> createState() => _ProfileSelfieScreenState();
}

class _ProfileSelfieScreenState extends State<ProfileSelfieScreen> {
  CameraController? controller;
  XFile? selfie;
  bool ready = false;
  bool opening = true;
  String? error;

  @override
  void initState() {
    super.initState();
    openCamera();
  }

  Future<void> openCamera() async {
    if (mounted) {
      setState(() {
        opening = true;
        error = null;
      });
    }

    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        throw Exception('No camera');
      }

      CameraDescription selected = cameras.first;

      for (final camera in cameras) {
        if (camera.lensDirection == CameraLensDirection.front) {
          selected = camera;
          break;
        }
      }

      final newController = CameraController(
        selected,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await newController.initialize();

      await controller?.dispose();

      if (!mounted) {
        await newController.dispose();
        return;
      }

      setState(() {
        controller = newController;
        ready = true;
        opening = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        ready = false;
        opening = false;
        error = 'Camera open nahi ho saka. Permission check karein.';
      });
    }
  }

  Future<void> capture() async {
    final camera = controller;

    if (camera == null ||
        !camera.value.isInitialized ||
        camera.value.isTakingPicture) {
      return;
    }

    try {
      final file = await camera.takePicture();

      if (!mounted) return;

      setState(() {
        selfie = file;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selfie successfully captured.'),
        ),
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selfie capture failed.'),
        ),
      );
    }
  }

  void complete() {
    if (selfie == null) {
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
      (_) => false,
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final captured = selfie != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Selfie Verification'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: captured
                    ? Image.file(
                        File(selfie!.path),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : ready
                        ? CameraPreview(controller!)
                        : Center(
                            child: opening
                                ? const CircularProgressIndicator()
                                : Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        error ??
                                            'Camera ready nahi hai.',
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 10),
                                      OutlinedButton(
                                        onPressed: openCamera,
                                        child: const Text(
                                          'Camera Dobara Kholein',
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              captured
                  ? 'Selfie Successfully Captured'
                  : 'Apni Live Selfie Capture Karein',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: ready
                    ? (captured
                        ? () {
                            setState(() {
                              selfie = null;
                            });
                          }
                        : capture)
                    : null,
                icon: Icon(
                  captured ? Icons.refresh : Icons.camera_alt,
                ),
                label: Text(
                  captured
                      ? 'Selfie Dobara Khinchein'
                      : 'Selfie Khinchein',
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: captured ? complete : null,
                child: const Text(
                  'Verification Complete Karein',
                  style: TextStyle(
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safe-Deals'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.verified,
                  color: Colors.green,
                  size: 48,
                ),
                SizedBox(height: 8),
                Text(
                  'Welcome to Safe-Deals',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text('Aapka verification complete hai.'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Vehicle Marketplace',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ActionCard(
            Icons.directions_car,
            'Buy Vehicle',
            'Vehicles browse karein',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VehicleCategories(),
                ),
              );
            },
          ),
          ActionCard(
            Icons.sell,
            'Sell Vehicle',
            'Apni vehicle list karein',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SellVehicleScreen(),
                ),
              );
            },
          ),
          ActionCard(
            Icons.person,
            'My Profile',
            'Profile details dekhein',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
          ),
          ActionCard(
            Icons.security,
            'Safe-Deals Verification',
            'Verification status dekhein',
            () {
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

class ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ActionCard(
    this.icon,
    this.title,
    this.subtitle,
    this.onTap, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
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
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }
}

class VehicleCategories extends StatelessWidget {
  const VehicleCategories({super.key});

  static const items = [
    ('Cars', Icons.directions_car),
    ('Bikes', Icons.two_wheeler),
    ('Scooters', Icons.electric_scooter),
    ('Tractors', Icons.agriculture),
    ('Trucks', Icons.local_shipping),
    ('Buses', Icons.directions_bus),
    ('Vans', Icons.airport_shuttle),
    ('Auto Rickshaw', Icons.electric_rickshaw),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Categories'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, index) {
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        VehicleListScreen(items[index].$1),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    items[index].$2,
                    size: 40,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    items[index].$1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class VehicleListScreen extends StatelessWidget {
  final String category;

  const VehicleListScreen(
    this.category, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final name in [
            '$category - Verified Model 2024',
            '$category - Verified Model 2023',
            '$category - Verified Model 2022',
          ])
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.directions_car),
                ),
                title: Text(name),
                subtitle: const Text('Verified vehicle'),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VehicleDetails(name),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class VehicleDetails extends StatelessWidget {
  final String name;

  const VehicleDetails(
    this.name, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Details'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.directions_car,
              size: 80,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text('Verification: Verified'),
          const Text('Documents: Available'),
          const Text('Seller: Verified Seller'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Enquiry submitted.'),
                ),
              );
            },
            child: const Text('Enquire Now'),
          ),
        ],
      ),
    );
  }
}

class SellVehicleScreen extends StatefulWidget {
  const SellVehicleScreen({super.key});

  @override
  State<SellVehicleScreen> createState() =>
      _SellVehicleScreenState();
}

class _SellVehicleScreenState extends State<SellVehicleScreen> {
  final name = TextEditingController();
  final price = TextEditingController();
  final city = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    price.dispose();
    city.dispose();
    super.dispose();
  }

  void submit() {
    if (name.text.trim().isEmpty ||
        price.text.trim().isEmpty ||
        city.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please sabhi details fill karein.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Listing Ready'),
        content: const Text(
          'Vehicle listing details save ho gayi hain.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell Vehicle'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Apni Vehicle List Karein',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: name,
            decoration: const InputDecoration(
              labelText: 'Vehicle Name / Model',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: price,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Expected Price',
              border: OutlineInputBorder(),
              prefixText: '₹ ',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: city,
            decoration: const InputDecoration(
              labelText: 'City / Location',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Photo upload ready for backend integration.',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add_a_photo),
            label: const Text('Vehicle Photos Add Karein'),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: submit,
              child: const Text('Submit Vehicle Listing'),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          CircleAvatar(
            radius: 48,
            backgroundColor: Color(0xFFE8F5E9),
            child: Icon(
              Icons.person,
              size: 55,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Text(
              'Verified Safe-Deals User',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(
              Icons.account_balance,
              color: Colors.green,
            ),
            title: Text('Bank Verification'),
            subtitle: Text('Completed'),
            trailing: Icon(
              Icons.verified,
              color: Colors.green,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.camera_alt,
              color: Colors.green,
            ),
            title: Text('Selfie Verification'),
            subtitle: Text('Completed'),
            trailing: Icon(
              Icons.verified,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safe-Deals Verification'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          Icon(
            Icons.verified,
            size: 90,
            color: Colors.green,
          ),
          SizedBox(height: 12),
          Center(
            child: Text(
              'Verification Complete',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 24),
          ListTile(
            leading: Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            title: Text('Bank Account'),
            subtitle: Text('Completed'),
          ),
          ListTile(
            leading: Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            title: Text('Live Selfie'),
            subtitle: Text('Completed'),
          ),
          ListTile(
            leading: Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            title: Text('Profile'),
            subtitle: Text('Verified'),
          ),
        ],
      ),
    );
  }
}
