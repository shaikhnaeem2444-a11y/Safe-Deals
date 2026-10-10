import 'package:flutter/material.dart';

void main() => runApp(const SafeDealsApp());

const red = Color(0xFFD71920);
const ink = Color(0xFF17191F);
const muted = Color(0xFF6B7078);
const line = Color(0xFFE7E8EB);
const soft = Color(0xFFF7F7F8);

class SafeDealsApp extends StatelessWidget {
  const SafeDealsApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Safe Deals',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: red, primary: red),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: ink,
            elevation: 0,
            centerTitle: false,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: line),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: line),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: red, width: 1.5),
            ),
          ),
        ),
        home: const WelcomeScreen(),
      );
}

class Vehicle {
  final String title, details, city, price, category, emoji;
  final int year;
  final bool featured;
  const Vehicle(this.title, this.details, this.city, this.price, this.category,
      this.emoji, this.year, {this.featured = false});
}

const vehicles = <Vehicle>[
  Vehicle('Hyundai Creta 2020', 'SX Diesel  ·  45,000 KM', 'Pune, Maharashtra', '₹ 9,85,000', 'Cars', '🚙', 2020, featured: true),
  Vehicle('Royal Enfield Classic 350', '2019  ·  21,000 KM', 'Pune, Maharashtra', '₹ 1,45,000', 'Bikes', '🏍️', 2019, featured: true),
  Vehicle('Mahindra 575 DI', '2018  ·  1800 HR', 'Pune, Maharashtra', '₹ 5,20,000', 'Tractors', '🚜', 2018, featured: true),
  Vehicle('Maruti Swift 2018', 'VXI Petrol  ·  32,000 KM', 'Pune', '₹ 4,25,000', 'Cars', '🚗', 2018),
  Vehicle('Honda Shine 2017', 'Petrol  ·  12,000 KM', 'Pune', '₹ 58,000', 'Bikes', '🏍️', 2017),
  Vehicle('Tata 407 2016', 'Diesel  ·  1,20,000 KM', 'Pune', '₹ 3,10,000', 'Trucks', '🚚', 2016),
  Vehicle('Honda Activa 2021', 'Petrol  ·  18,000 KM', 'Pune', '₹ 62,000', 'Scooters', '🛵', 2021),
  Vehicle('Force Traveller 2020', 'Diesel  ·  52,000 KM', 'Pune', '₹ 8,75,000', 'Vans', '🚐', 2020),
];

const categories = [
  ('Cars', '🚗'), ('Bikes', '🏍️'), ('Scooters', '🛵'), ('Tractors', '🚜'),
  ('Trucks', '🚚'), ('Commercial Vehicles', '🚛'), ('JCB & Construction', '🚜'),
  ('Buses', '🚌'), ('Vans', '🚐'), ('Auto Rickshaw', '🛺'),
];

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  width: 100, height: 110,
                  decoration: BoxDecoration(color: red, borderRadius: BorderRadius.circular(28)),
                  child: const Icon(Icons.verified_user, color: Colors.white, size: 70),
                ),
                const SizedBox(height: 24),
                const Text('SAFE DEALS', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 1)),
                const Text('Verified Vehicles. Safe Deals.', style: TextStyle(color: muted, fontSize: 15)),
                const SizedBox(height: 26),
                const Text('Buy and sell vehicles with confidence.',
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700)),
                const SizedBox(height: 20),
                const _TrustRow(icon: Icons.verified_user_outlined, title: 'Verified Sellers', subtitle: 'Safer vehicle deals'),
                const _TrustRow(icon: Icons.directions_car_outlined, title: 'Genuine Vehicles', subtitle: 'Vehicle listings in one place'),
                const _TrustRow(icon: Icons.lock_outline, title: 'Safe & Secure', subtitle: 'Stay alert and trade safely'),
                const Spacer(),
                SizedBox(width: double.infinity, height: 54, child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: red, foregroundColor: Colors.white),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                  child: const Text('Get Started', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                )),
                const SizedBox(height: 12),
                SizedBox(width: double.infinity, height: 50, child: OutlinedButton(
                  style: OutlinedButton.styleFrom(foregroundColor: red, side: const BorderSide(color: red)),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                  child: const Text('I Already Have an Account'),
                )),
                const SizedBox(height: 12),
                const Text('By continuing, you agree to our Terms of Service and Privacy Policy.',
                    textAlign: TextAlign.center, style: TextStyle(color: muted, fontSize: 11)),
              ],
            ),
          ),
        ),
      );
}

class _TrustRow extends StatelessWidget {
  final IconData icon; final String title, subtitle;
  const _TrustRow({required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(children: [
      Container(width: 48, height: 48, decoration: BoxDecoration(color: const Color(0xFFFFEEEE), borderRadius: BorderRadius.circular(13)),
        child: Icon(icon, color: red, size: 26)),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(subtitle, style: const TextStyle(color: muted, fontSize: 13)),
      ])),
      const Icon(Icons.check_circle, color: Color(0xFF269A55), size: 20),
    ]),
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final phone = TextEditingController();
  @override void dispose() { phone.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(leading: const BackButton(), title: const Text('Login / Register')),
    body: Padding(padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 18),
      const Text('Enter your mobile number', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Text('Use your mobile number to continue to Safe Deals.', style: TextStyle(color: muted)),
      const SizedBox(height: 28),
      TextField(controller: phone, keyboardType: TextInputType.phone, maxLength: 10,
        decoration: const InputDecoration(labelText: 'Mobile Number', prefixText: '+91  ', prefixIcon: Icon(Icons.phone_android))),
      const SizedBox(height: 18),
      SizedBox(width: double.infinity, height: 52, child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: red, foregroundColor: Colors.white),
        onPressed: () {
          if (phone.text.trim().length != 10) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('10 digit mobile number enter karein.')));
            return;
          }
          Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen(phone: phone.text.trim())));
        }, child: const Text('Continue'))),
      const Spacer(),
      const Center(child: Text('🔒  Your information stays private', style: TextStyle(color: muted))),
      const SizedBox(height: 18),
    ])),
  );
}

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});
  @override State<OtpScreen> createState() => _OtpScreenState();
}
class _OtpScreenState extends State<OtpScreen> {
  final otp = TextEditingController();
  @override void dispose() { otp.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Verify OTP')),
    body: Padding(padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 20),
      const Text('Enter verification code', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Text('Demo flow for ${widget.phone}. Real SMS OTP needs an authentication service.', style: const TextStyle(color: muted)),
      const SizedBox(height: 25),
      TextField(controller: otp, keyboardType: TextInputType.number, maxLength: 6, decoration: const InputDecoration(labelText: '6-digit OTP')),
      const SizedBox(height: 16),
      SizedBox(width: double.infinity, height: 52, child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: red, foregroundColor: Colors.white),
        onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainShell()), (r) => false),
        child: const Text('Verify & Continue'))),
    ])),
  );
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override State<MainShell> createState() => _MainShellState();
}
class _MainShellState extends State<MainShell> {
  int index = 0;
  @override Widget build(BuildContext context) {
    final pages = [const HomeTab(), const SearchTab(), const SellTab(), const ChatsTab(), const ProfileTab()];
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: SafeArea(top: false, child: Container(
        decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: line))),
        child: Row(children: [
          _NavItem(icon: Icons.home_filled, label: 'Home', active: index == 0, onTap: () => setState(() => index = 0)),
          _NavItem(icon: Icons.search, label: 'Search', active: index == 1, onTap: () => setState(() => index = 1)),
          Expanded(child: GestureDetector(onTap: () => setState(() => index = 2), child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7), child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 56, height: 48, decoration: BoxDecoration(color: red, borderRadius: BorderRadius.circular(24)),
                child: const Icon(Icons.add, color: Colors.white, size: 32)),
              const Text('SELL', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: red)),
            ])))),
          _NavItem(icon: Icons.chat_bubble_outline, label: 'Chats', active: index == 3, onTap: () => setState(() => index = 3)),
          _NavItem(icon: Icons.person_outline, label: 'Profile', active: index == 4, onTap: () => setState(() => index = 4)),
        ]),
      )),
    );
  }
}
class _NavItem extends StatelessWidget {
  final IconData icon; final String label; final bool active; final VoidCallback onTap;
  const _NavItem({required this.icon, required this.label, required this.active, required this.onTap});
  @override Widget build(BuildContext context) => Expanded(child: InkWell(onTap: onTap, child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 12), child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: active ? red : ink, size: 25),
      const SizedBox(height: 3),
      Text(label, style: TextStyle(color: active ? red : ink, fontWeight: active ? FontWeight.bold : FontWeight.normal, fontSize: 11)),
    ]),
  )));
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override Widget build(BuildContext context) => SafeArea(child: CustomScrollView(slivers: [
    SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(18, 8, 18, 10), child: Row(children: [
      const Icon(Icons.menu, size: 27), const SizedBox(width: 14),
      Container(width: 42, height: 42, decoration: BoxDecoration(color: red, borderRadius: BorderRadius.circular(13)),
        child: const Icon(Icons.shield_outlined, color: Colors.white, size: 29)),
      const SizedBox(width: 8),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text.rich(TextSpan(children: [TextSpan(text: 'SAFE ', style: TextStyle(color: ink)), TextSpan(text: 'DEALS', style: TextStyle(color: red))]),
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
        Text('Verified People • Genuine Vehicles • Safer Deals', style: TextStyle(fontSize: 8, color: muted)),
      ])),
      IconButton(onPressed: () => _open(context, const NotificationsScreen()), icon: const Icon(Icons.notifications_none)),
      IconButton(onPressed: () => _open(context, const ChatsTab()), icon: const Icon(Icons.chat_bubble_outline)),
    ]))),
    SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 18), child: GestureDetector(
      onTap: () => _open(context, const SearchTab()),
      child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(border: Border.all(color: line), borderRadius: BorderRadius.circular(16)),
        child: const Row(children: [Icon(Icons.search, color: ink), SizedBox(width: 10), Expanded(child: Text('Search vehicles, brand, model...', style: TextStyle(color: muted))),
          Icon(Icons.location_on, color: red), Text('Pune', style: TextStyle(fontWeight: FontWeight.bold)), Icon(Icons.keyboard_arrow_down)]),
      ),
    ))),
    SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(18, 14, 18, 8), child: Container(
      height: 180, padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), gradient: const LinearGradient(colors: [Color(0xFF10151D), Color(0xFF354150)])),
      child: Stack(children: [
        Positioned(right: -5, bottom: 0, child: Icon(Icons.directions_car, size: 145, color: Colors.white.withValues(alpha: .20))),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('BUY & SELL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 24)),
          const Text('VEHICLES SAFELY', style: TextStyle(color: red, fontWeight: FontWeight.w900, fontSize: 24)),
          const SizedBox(height: 10),
          const Text('✓ Verified Sellers    ✓ Genuine Vehicles', style: TextStyle(color: Colors.white, fontSize: 11)),
          const Spacer(),
          ElevatedButton.icon(onPressed: () => _open(context, const SellTab()),
            style: ElevatedButton.styleFrom(backgroundColor: red, foregroundColor: Colors.white, visualDensity: VisualDensity.compact),
            icon: const Icon(Icons.arrow_forward, size: 17), label: const Text('POST YOUR VEHICLE')),
        ]),
      ]),
    ))),
    SliverToBoxAdapter(child: _SectionHeader(title: 'Browse Categories', onViewAll: () => _open(context, const SearchTab()))),
    SliverToBoxAdapter(child: SizedBox(height: 196, child: GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 18), physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: .78),
      itemCount: categories.length, itemBuilder: (context, i) => InkWell(
        onTap: () => _open(context, SearchTab(initialCategory: categories[i].$1)),
        child: Container(decoration: BoxDecoration(border: Border.all(color: line), borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.all(4), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(categories[i].$2, style: const TextStyle(fontSize: 25)),
            const SizedBox(height: 7),
            Text(categories[i].$1, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
          ])),
      ),
    ))),
    SliverToBoxAdapter(child: _SectionHeader(title: 'Featured Vehicles', onViewAll: () => _open(context, const SearchTab()))),
    SliverToBoxAdapter(child: SizedBox(height: 250, child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 18), scrollDirection: Axis.horizontal,
      itemCount: vehicles.where((v) => v.featured).length, separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, i) => VehicleCard(vehicle: vehicles.where((v) => v.featured).toList()[i], compact: true),
    ))),
    SliverToBoxAdapter(child: _SectionHeader(title: 'Explore Near You', onViewAll: () => _open(context, const SearchTab()))),
    SliverToBoxAdapter(child: SizedBox(height: 38, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 18),
      children: ['All', 'Cars', 'Bikes', 'Tractors', 'Trucks', 'More'].map((c) => Padding(
        padding: const EdgeInsets.only(right: 8), child: ActionChip(label: Text(c), onPressed: () => _open(context, SearchTab(initialCategory: c == 'All' || c == 'More' ? null : c)),
          side: BorderSide(color: c == 'All' ? red : line), backgroundColor: c == 'All' ? const Color(0xFFFFEEEE) : Colors.white),
      )).toList(),
    ))),
    SliverToBoxAdapter(child: SizedBox(height: 245, child: ListView.separated(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 8), scrollDirection: Axis.horizontal,
      itemCount: vehicles.length, separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, i) => VehicleCard(vehicle: vehicles[i], compact: true),
    ))),
    const SliverToBoxAdapter(child: SizedBox(height: 14)),
  ]));
}

void _open(BuildContext context, Widget page) => Navigator.push(context, MaterialPageRoute(builder: (_) => page));

class _SectionHeader extends StatelessWidget {
  final String title; final VoidCallback onViewAll;
  const _SectionHeader({required this.title, required this.onViewAll});
  @override Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
    child: Row(children: [Expanded(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800))),
      TextButton(onPressed: onViewAll, child: const Text('View All  ›', style: TextStyle(color: red, fontWeight: FontWeight.bold)))],
    ),
  );
}

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle; final bool compact;
  const VehicleCard({super.key, required this.vehicle, this.compact = false});
  @override Widget build(BuildContext context) => InkWell(
    onTap: () => _open(context, VehicleDetailsScreen(vehicle: vehicle)),
    child: Container(width: compact ? 205 : double.infinity,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: line), borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(height: compact ? 112 : 190, width: double.infinity,
          decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFE7E9ED), Color(0xFFD4D8DF)])),
          child: Stack(children: [
            Center(child: Text(vehicle.emoji, style: TextStyle(fontSize: compact ? 68 : 115))),
            if (vehicle.featured) Positioned(left: 8, top: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: red, borderRadius: BorderRadius.circular(6)),
              child: const Text('FEATURED', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 9)))),
            Positioned(right: 5, top: 3, child: IconButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login karke favourites save karein.'))),
              icon: const Icon(Icons.favorite_border, color: Colors.white, shadows: [Shadow(blurRadius: 4, color: ink)]))),
          ]),
        ),
        Padding(padding: const EdgeInsets.fromLTRB(10, 8, 10, 9), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(vehicle.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 4),
          Text(vehicle.details, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: muted, fontSize: 10)),
          const SizedBox(height: 5),
          Text(vehicle.price, style: const TextStyle(color: red, fontWeight: FontWeight.w900, fontSize: 15)),
          const SizedBox(height: 4),
          Row(children: [const Icon(Icons.location_on, size: 13, color: muted), Expanded(child: Text(vehicle.city, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: muted, fontSize: 10)))]),
        ])),
      ]),
    ),
  );
}

class SearchTab extends StatefulWidget {
  final String? initialCategory;
  const SearchTab({super.key, this.initialCategory});
  @override State<SearchTab> createState() => _SearchTabState();
}
class _SearchTabState extends State<SearchTab> {
  late String category;
  String query = '';
  @override void initState() { super.initState(); category = widget.initialCategory ?? 'All'; }
  @override Widget build(BuildContext context) {
    final filtered = vehicles.where((v) =>
      (category == 'All' || v.category == category) &&
      ('${v.title} ${v.details} ${v.city} ${v.category}'.toLowerCase().contains(query.toLowerCase()))).toList();
    return SafeArea(child: Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(18, 14, 18, 10), child: Row(children: [
        const Expanded(child: Text('Search Vehicles', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900))),
        IconButton(onPressed: () => _open(context, const FiltersScreen()), icon: const Icon(Icons.tune)),
      ])),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 18), child: TextField(
        onChanged: (v) => setState(() => query = v),
        decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search make, model or vehicle...'),
      )),
      SizedBox(height: 54, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        children: ['All', ...categories.map((e) => e.$1)].map((c) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4), child: ChoiceChip(label: Text(c), selected: category == c,
            selectedColor: const Color(0xFFFFE7E8), onSelected: (_) => setState(() => category = c),
            side: BorderSide(color: category == c ? red : line)),
        )).toList(),
      )),
      Expanded(child: filtered.isEmpty ? const Center(child: Text('No vehicles found.')) : ListView.separated(
        padding: const EdgeInsets.all(16), itemCount: filtered.length, separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) => VehicleCard(vehicle: filtered[i]),
      )),
    ]));
  }
}

class VehicleDetailsScreen extends StatelessWidget {
  final Vehicle vehicle;
  const VehicleDetailsScreen({super.key, required this.vehicle});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Vehicle Details'), actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)), IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined))]),
    body: ListView(children: [
      Container(height: 245, color: const Color(0xFFE7E9ED), child: Center(child: Text(vehicle.emoji, style: const TextStyle(fontSize: 150)))),
      Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Expanded(child: Text(vehicle.title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900))), const Icon(Icons.verified, color: Color(0xFF279A55))]),
        const SizedBox(height: 8),
        Text(vehicle.price, style: const TextStyle(color: red, fontWeight: FontWeight.w900, fontSize: 25)),
        const SizedBox(height: 15),
        Row(children: [const Icon(Icons.calendar_month, color: muted), const SizedBox(width: 6), Text('${vehicle.year}'), const SizedBox(width: 18), const Icon(Icons.speed, color: muted), const SizedBox(width: 6), Text(vehicle.details)]),
        const Divider(height: 28),
        Row(children: [const Icon(Icons.location_on_outlined, color: muted), const SizedBox(width: 6), Text(vehicle.city), const Spacer(), TextButton(onPressed: () {}, child: const Text('View on Map'))]),
        const SizedBox(height: 12),
        const Text('Seller Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const ListTile(contentPadding: EdgeInsets.zero, leading: CircleAvatar(backgroundColor: Color(0xFFFFE7E8), child: Icon(Icons.person, color: red)),
          title: Text('Safe Deals Seller'), subtitle: Text('Seller details shown after sign-in'), trailing: Icon(Icons.verified, color: Color(0xFF279A55))),
        const Text('Vehicle Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Vehicle details are provided by the seller. Check the vehicle, documents and ownership before making payment. Never pay an advance to an unknown seller.'),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: OutlinedButton.icon(onPressed: () => _open(context, const ChatsTab()), icon: const Icon(Icons.chat_bubble_outline), label: const Text('Chat'))),
          const SizedBox(width: 10),
          Expanded(child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: red, foregroundColor: Colors.white),
            onPressed: () => _open(context, const ChatsTab()), icon: const Icon(Icons.local_offer_outlined), label: const Text('Make Offer')),
        ]),
      ])),
    ]),
  );
}

class SellTab extends StatefulWidget {
  const SellTab({super.key});
  @override State<SellTab> createState() => _SellTabState();
}
class _SellTabState extends State<SellTab> {
  final formKey = GlobalKey<FormState>();
  final brand = TextEditingController(), model = TextEditingController(), year = TextEditingController(),
    km = TextEditingController(), price = TextEditingController(), city = TextEditingController(text: 'Pune'),
    area = TextEditingController(), description = TextEditingController();
  String category = 'Cars', fuel = 'Petrol', transmission = 'Manual';
  @override void dispose() { for (final c in [brand, model, year, km, price, city, area, description]) { c.dispose(); } super.dispose(); }
  @override Widget build(BuildContext context) => SafeArea(child: Form(key: formKey, child: ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Post Your Vehicle', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
    const Text('Fill accurate details to get better responses', style: TextStyle(color: muted)),
    const SizedBox(height: 20),
    Container(height: 100, decoration: BoxDecoration(color: soft, border: Border.all(color: line), borderRadius: BorderRadius.circular(12)),
      child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_photo_alternate_outlined, size: 30, color: red), SizedBox(width: 10), Text('Add vehicle photos', style: TextStyle(fontWeight: FontWeight.bold))])),
    const SizedBox(height: 18),
    const Text('1. Select Category', style: TextStyle(fontWeight: FontWeight.bold)),
    const SizedBox(height: 8),
    DropdownButtonFormField<String>(value: category, decoration: const InputDecoration(), items: categories.map((e) => DropdownMenuItem(value: e.$1, child: Text(e.$1))).toList(), onChanged: (v) => setState(() => category = v ?? 'Cars')),
    const SizedBox(height: 16),
    const Text('2. Basic Details', style: TextStyle(fontWeight: FontWeight.bold)),
    const SizedBox(height: 8),
    _formField(brand, 'Brand *', required: true),
    _formField(model, 'Model *', required: true),
    Row(children: [Expanded(child: _formField(year, 'Year *', required: true, numeric: true)), const SizedBox(width: 10), Expanded(child: _formField(km, 'KM Driven', numeric: true))]),
    Row(children: [Expanded(child: DropdownButtonFormField<String>(value: fuel, decoration: const InputDecoration(labelText: 'Fuel Type'), items: ['Petrol','Diesel','CNG','Electric','Hybrid'].map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(), onChanged: (v) => setState(() => fuel = v ?? 'Petrol'))),
      const SizedBox(width: 10), Expanded(child: DropdownButtonFormField<String>(value: transmission, decoration: const InputDecoration(labelText: 'Transmission'), items: ['Manual','Automatic'].map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(), onChanged: (v) => setState(() => transmission = v ?? 'Manual')))]),
    const SizedBox(height: 16),
    const Text('3. Price & Location', style: TextStyle(fontWeight: FontWeight.bold)),
    const SizedBox(height: 8),
    _formField(price, 'Expected Price (₹) *', required: true, numeric: true),
    _formField(city, 'City *', required: true),
    _formField(area, 'Area / Locality'),
    _formField(description, 'Vehicle Description', maxLines: 3),
    const SizedBox(height: 14),
    SizedBox(height: 52, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: red, foregroundColor: Colors.white),
      onPressed: () {
        if (!(formKey.currentState?.validate() ?? false)) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Details ready. Online publishing requires a connected listing service.')));
      }, child: const Text('Submit for Review', style: TextStyle(fontWeight: FontWeight.bold)))),
    const SizedBox(height: 12),
    const Text('Your ad can go live after verification.', textAlign: TextAlign.center, style: TextStyle(color: muted, fontSize: 12)),
  ])));
  Widget _formField(TextEditingController c, String label, {bool required = false, bool numeric = false, int maxLines = 1}) =>
    Padding(padding: const EdgeInsets.only(bottom: 10), child: TextFormField(controller: c, maxLines: maxLines,
      keyboardType: numeric ? TextInputType.number : TextInputType.text,
      validator: required ? (v) => (v == null || v.trim().isEmpty) ? 'Required' : null : null,
      decoration: InputDecoration(labelText: label)));
}

class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key});
  @override Widget build(BuildContext context) => SafeArea(child: Column(children: [
    const Padding(padding: EdgeInsets.all(18), child: Align(alignment: Alignment.centerLeft, child: Text('Chats & Offers', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)))),
    Expanded(child: ListView(children: [
      ListTile(leading: const CircleAvatar(backgroundColor: Color(0xFFFFE7E8), child: Icon(Icons.person, color: red)),
        title: const Text('Safe Deals Support', style: TextStyle(fontWeight: FontWeight.bold)), subtitle: const Text('Keep your transactions safe'),
        trailing: const Icon(Icons.chevron_right), onTap: () => _open(context, const ChatDetailScreen())),
      const Divider(indent: 72),
      const Padding(padding: EdgeInsets.all(24), child: Text('Your buyer and seller conversations will appear here.', textAlign: TextAlign.center, style: TextStyle(color: muted))),
    ])),
  ]));
}
class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});
  @override State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}
class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final message = TextEditingController(); final messages = <String>['Welcome to Safe Deals Support. Never share OTP or banking PINs.'];
  @override void dispose() { message.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Safe Deals Support')),
    body: Column(children: [
      Expanded(child: ListView(padding: const EdgeInsets.all(16), children: messages.map((m) => Align(alignment: Alignment.centerRight, child: Container(
        margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: const Color(0xFFFFE7E8), borderRadius: BorderRadius.circular(14)), child: Text(m)))).toList())),
      SafeArea(child: Padding(padding: const EdgeInsets.all(10), child: Row(children: [
        Expanded(child: TextField(controller: message, decoration: const InputDecoration(hintText: 'Type a message...'))),
        IconButton(onPressed: () { if (message.text.trim().isNotEmpty) setState(() { messages.add(message.text.trim()); message.clear(); }); }, icon: const Icon(Icons.send, color: red)),
      ]))),
    ]));
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override Widget build(BuildContext context) => SafeArea(child: ListView(padding: const EdgeInsets.all(18), children: [
    const Text('My Profile', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
    const SizedBox(height: 20),
    const Center(child: CircleAvatar(radius: 42, backgroundColor: Color(0xFFFFE7E8), child: Icon(Icons.person, size: 50, color: red))),
    const SizedBox(height: 10),
    const Center(child: Text('Safe Deals User', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold))),
    const Center(child: Text('Complete your profile to build trust', style: TextStyle(color: muted))),
    const SizedBox(height: 24),
    _ProfileTile(icon: Icons.directions_car_outlined, title: 'My Listings', onTap: () => _open(context, const MyListingsScreen())),
    _ProfileTile(icon: Icons.favorite_border, title: 'Favourites', onTap: () => _open(context, const FavouritesScreen())),
    _ProfileTile(icon: Icons.workspace_premium_outlined, title: 'Subscription Plans', onTap: () => _open(context, const SubscriptionScreen())),
    _ProfileTile(icon: Icons.verified_user_outlined, title: 'Safe Deals Verification', onTap: () => _open(context, const SafetyScreen())),
    _ProfileTile(icon: Icons.notifications_none, title: 'Notifications', onTap: () => _open(context, const NotificationsScreen())),
    _ProfileTile(icon: Icons.settings_outlined, title: 'Settings', onTap: () => _open(context, const SettingsScreen())),
    _ProfileTile(icon: Icons.help_outline, title: 'Help & Support', onTap: () => _open(context, const ChatDetailScreen())),
    const SizedBox(height: 18),
    OutlinedButton(onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const WelcomeScreen()), (_) => false), child: const Text('Log Out')),
  ]));
}
class _ProfileTile extends StatelessWidget {
  final IconData icon; final String title; final VoidCallback onTap;
  const _ProfileTile({required this.icon, required this.title, required this.onTap});
  @override Widget build(BuildContext context) => Card(color: Colors.white, elevation: 0, shape: RoundedRectangleBorder(side: const BorderSide(color: line), borderRadius: BorderRadius.circular(13)),
    child: ListTile(leading: Container(width: 42, height: 42, decoration: BoxDecoration(color: const Color(0xFFFFEEEE), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: red)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)), trailing: const Icon(Icons.chevron_right), onTap: onTap));
}

class MyListingsScreen extends StatelessWidget {
  const MyListingsScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('My Listings')),
    body: const Center(child: Padding(padding: EdgeInsets.all(28), child: Text('Aapki posted vehicles yahan dikhengi.', textAlign: TextAlign.center, style: TextStyle(color: muted)))));
}
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Favourites')),
    body: const Center(child: Text('Saved vehicles yahan dikhengi.', style: TextStyle(color: muted))));
}
class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Subscription Plans')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      const Text('Choose a plan to start buying & selling', style: TextStyle(color: muted)),
      const SizedBox(height: 18),
      _PlanCard(name: 'Monthly Plan', price: '₹199', period: '/ month', tag: 'MOST POPULAR'),
      _PlanCard(name: 'Quarterly Plan', price: '₹499', period: '/ 3 months', tag: 'Save ₹98'),
      _PlanCard(name: 'Yearly Plan', price: '₹1,599', period: '/ year', tag: 'Save ₹789'),
      const SizedBox(height: 12),
      const Text('Plan selection is a UI preview. Secure subscription payments need billing integration.', style: TextStyle(color: muted, fontSize: 12)),
    ]));
}
class _PlanCard extends StatelessWidget {
  final String name, price, period, tag;
  const _PlanCard({required this.name, required this.price, required this.period, required this.tag});
  @override Widget build(BuildContext context) => Card(color: Colors.white, elevation: 0, shape: RoundedRectangleBorder(side: const BorderSide(color: line), borderRadius: BorderRadius.circular(15)),
    child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(tag, style: const TextStyle(color: red, fontWeight: FontWeight.bold, fontSize: 11)),
      const SizedBox(height: 6),
      Row(children: [Expanded(child: Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        Text(price, style: const TextStyle(fontSize: 22, color: red, fontWeight: FontWeight.w900)), Text(period, style: const TextStyle(color: muted))]),
      const SizedBox(height: 12),
      const Text('✓  Post vehicle listings\n✓  Chat with buyers\n✓  Verified seller badge\n✓  Safety support'),
      const SizedBox(height: 12),
      SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment integration pending.'))), child: const Text('Choose Plan'))),
    ])));
}
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Notifications')),
    body: ListView(children: const [
      ListTile(leading: Icon(Icons.shield_outlined, color: red), title: Text('Stay safe on Safe Deals'), subtitle: Text('Never share OTP, PIN or advance payment with unknown sellers.')),
      Divider(),
      ListTile(leading: Icon(Icons.directions_car_outlined, color: red), title: Text('Vehicle marketplace'), subtitle: Text('New alerts and listing updates will appear here.')),
    ]));
}
class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Safety Center')),
    body: ListView(padding: const EdgeInsets.all(18), children: const [
      Icon(Icons.verified_user, color: red, size: 70),
      SizedBox(height: 12),
      Text('Trade safely with Safe Deals', textAlign: TextAlign.center, style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
      SizedBox(height: 22),
      ListTile(leading: Icon(Icons.check_circle, color: Colors.green), title: Text('Meet in a public place'), subtitle: Text('Inspect the vehicle before paying.')),
      ListTile(leading: Icon(Icons.check_circle, color: Colors.green), title: Text('Check documents'), subtitle: Text('Confirm RC, insurance and seller ownership.')),
      ListTile(leading: Icon(Icons.warning_amber, color: red), title: Text('Never share OTP or PIN'), subtitle: Text('Do not send advance money to unknown people.')),
      ListTile(leading: Icon(Icons.info_outline, color: red), title: Text('Verification status'), subtitle: Text('Bank and identity verification must be connected to a real verification service before being treated as verified.')),
    ]));
}
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Settings')),
    body: ListView(children: const [
      ListTile(leading: Icon(Icons.person_outline), title: Text('Account details'), trailing: Icon(Icons.chevron_right)),
      ListTile(leading: Icon(Icons.lock_outline), title: Text('Privacy & Security'), trailing: Icon(Icons.chevron_right)),
      ListTile(leading: Icon(Icons.notifications_none), title: Text('Notification preferences'), trailing: Icon(Icons.chevron_right)),
      ListTile(leading: Icon(Icons.description_outlined), title: Text('Terms & Privacy Policy'), trailing: Icon(Icons.chevron_right)),
    ]));
}
class FiltersScreen extends StatelessWidget {
  const FiltersScreen({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Filters')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      const Text('Refine your search', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 18),
      const TextField(decoration: InputDecoration(labelText: 'Minimum price', prefixText: '₹ ')),
      const SizedBox(height: 12),
      const TextField(decoration: InputDecoration(labelText: 'Maximum price', prefixText: '₹ ')),
      const SizedBox(height: 12),
      const TextField(decoration: InputDecoration(labelText: 'City / Location', prefixIcon: Icon(Icons.location_on_outlined))),
      const SizedBox(height: 20),
      SizedBox(height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: red, foregroundColor: Colors.white),
        onPressed: () => Navigator.pop(context), child: const Text('Apply Filters'))),
    ]));
}
