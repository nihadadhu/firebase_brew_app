import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Premium Settings',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFE8D5B7),
          surface: const Color(0xFF0E0E0F),
          onSurface: const Color(0xFFF5F0E8),
        ),
        fontFamily: 'Georgia',
      ),
      home: const SettingsScreen(),
    );
  }
}

// ─── Color Palette ────────────────────────────────────────────────
const kBg = Color(0xFF0A0A0B);
const kSurface = Color(0xFF141416);
const kCard = Color(0xFF1A1A1D);
const kBorder = Color(0xFF2A2A2E);
const kGold = Color(0xFFD4A853);
const kGoldLight = Color(0xFFE8C87A);
const kCream = Color(0xFFF2EAD9);
const kMuted = Color(0xFF8A8A8F);
const kAccent = Color(0xFF4A9EFF);

// ─── Settings Screen ─────────────────────────────────────────────
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  bool _notificationsEnabled = true;
  bool _biometricEnabled = false;
  bool _analyticsEnabled = true;
  bool _darkModeEnabled = true;
  double _textScale = 1.0;
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      backgroundColor: kBg,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildAppBar(),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 8),
                  _buildProfileCard(),
                  const SizedBox(height: 28),
                  _buildSectionLabel('Preferences'),
                  const SizedBox(height: 12),
                  _buildPreferencesCard(),
                  const SizedBox(height: 28),
                  _buildSectionLabel('Security'),
                  const SizedBox(height: 12),
                  _buildSecurityCard(),
                  const SizedBox(height: 28),
                  _buildSectionLabel('Appearance'),
                  const SizedBox(height: 12),
                  _buildAppearanceCard(),
                  const SizedBox(height: 28),
                  _buildSectionLabel('Support'),
                  const SizedBox(height: 12),
                  _buildSupportCard(),
                  const SizedBox(height: 28),
                  _buildDangerCard(),
                  const SizedBox(height: 48),
                  _buildVersionTag(),
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── App Bar ──────────────────────────────────────────────────────
  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: kBg,
      pinned: true,
      expandedHeight: 110,
      collapsedHeight: 60,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8, top: 4),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: kCream, size: 18),
          onPressed: () {},
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: kCream,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            fontFamily: 'Georgia',
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF141416), kBg],
            ),
          ),
        ),
      ),
    );
  }

  // ── Profile Card ─────────────────────────────────────────────────
  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBorder, width: 1),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E1C18), Color(0xFF141416)],
        ),
      ),
      child: Row(
        children: [
          // Avatar with gold ring
          Container(
            padding: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [kGold, kGoldLight, kGold],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              width: 58,
              height: 58,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF252320),
              ),
              child: const Center(
                child: Text(
                  'JD',
                  style: TextStyle(
                    color: kGoldLight,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'James Durant',
                      style: TextStyle(
                        color: kCream,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildPremiumBadge(),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'james.durant@email.com',
                  style: TextStyle(
                    color: kMuted,
                    fontSize: 13,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: kBorder,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.edit_outlined,
                color: kMuted, size: 17),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8B6914), kGold],
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, color: kCream, size: 10),
          SizedBox(width: 3),
          Text(
            'PRO',
            style: TextStyle(
              color: kCream,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  // ── Section Label ────────────────────────────────────────────────
  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 14,
            decoration: BoxDecoration(
              color: kGold,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: kMuted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
            ),
          ),
        ],
      ),
    );
  }

  // ── Preferences Card ─────────────────────────────────────────────
  Widget _buildPreferencesCard() {
    return _buildCard([
      _buildToggleTile(
        icon: Icons.notifications_outlined,
        label: 'Notifications',
        subtitle: 'Push alerts and reminders',
        value: _notificationsEnabled,
        onChanged: (v) => setState(() => _notificationsEnabled = v),
        iconColor: const Color(0xFF6B9EFF),
      ),
      _buildDivider(),
      _buildToggleTile(
        icon: Icons.bar_chart_rounded,
        label: 'Analytics',
        subtitle: 'Help improve the product',
        value: _analyticsEnabled,
        onChanged: (v) => setState(() => _analyticsEnabled = v),
        iconColor: const Color(0xFF5DC896),
      ),
      _buildDivider(),
      _buildNavTile(
        icon: Icons.language_rounded,
        label: 'Language',
        value: _selectedLanguage,
        iconColor: const Color(0xFFFF9F5B),
        onTap: () {},
      ),
    ]);
  }

  // ── Security Card ────────────────────────────────────────────────
  Widget _buildSecurityCard() {
    return _buildCard([
      _buildToggleTile(
        icon: Icons.fingerprint_rounded,
        label: 'Biometric Auth',
        subtitle: 'Face ID / Fingerprint',
        value: _biometricEnabled,
        onChanged: (v) => setState(() => _biometricEnabled = v),
        iconColor: const Color(0xFFFF6B9E),
      ),
      _buildDivider(),
      _buildNavTile(
        icon: Icons.lock_outline_rounded,
        label: 'Change Password',
        iconColor: const Color(0xFFB88EFF),
        onTap: () {},
      ),
      _buildDivider(),
      _buildNavTile(
        icon: Icons.devices_rounded,
        label: 'Active Sessions',
        value: '2 devices',
        iconColor: const Color(0xFF5DC896),
        onTap: () {},
      ),
    ]);
  }

  // ── Appearance Card ──────────────────────────────────────────────
  Widget _buildAppearanceCard() {
    return _buildCard([
      _buildToggleTile(
        icon: Icons.dark_mode_outlined,
        label: 'Dark Mode',
        subtitle: 'Easy on the eyes',
        value: _darkModeEnabled,
        onChanged: (v) => setState(() => _darkModeEnabled = v),
        iconColor: const Color(0xFF8B8BFF),
      ),
      _buildDivider(),
      _buildSliderTile(
        icon: Icons.text_fields_rounded,
        label: 'Text Size',
        value: _textScale,
        iconColor: kGold,
        onChanged: (v) => setState(() => _textScale = v),
      ),
    ]);
  }

  // ── Support Card ─────────────────────────────────────────────────
  Widget _buildSupportCard() {
    return _buildCard([
      _buildNavTile(
        icon: Icons.help_outline_rounded,
        label: 'Help Center',
        iconColor: const Color(0xFF5DC896),
        onTap: () {},
      ),
      _buildDivider(),
      _buildNavTile(
        icon: Icons.chat_bubble_outline_rounded,
        label: 'Contact Support',
        iconColor: const Color(0xFF6B9EFF),
        onTap: () {},
      ),
      _buildDivider(),
      _buildNavTile(
        icon: Icons.star_outline_rounded,
        label: 'Rate the App',
        iconColor: kGold,
        onTap: () {},
      ),
    ]);
  }

  // ── Danger Zone ──────────────────────────────────────────────────
  Widget _buildDangerCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1212),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3A2020), width: 1),
      ),
      child: Column(
        children: [
          _buildNavTile(
            icon: Icons.logout_rounded,
            label: 'Sign Out',
            iconColor: const Color(0xFFFF7262),
            labelColor: const Color(0xFFFF7262),
            showChevron: false,
            onTap: () {},
          ),
          _buildDivider(color: const Color(0xFF3A2020)),
          _buildNavTile(
            icon: Icons.delete_outline_rounded,
            label: 'Delete Account',
            iconColor: const Color(0xFFFF3B30),
            labelColor: const Color(0xFFFF3B30),
            showChevron: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ── Version Tag ──────────────────────────────────────────────────
  Widget _buildVersionTag() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 36,
            height: 1,
            color: kBorder,
          ),
          const SizedBox(height: 14),
          const Text(
            'Version 3.4.1 · Build 2024.12',
            style: TextStyle(
              color: Color(0xFF555560),
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // ── Shared Builders ──────────────────────────────────────────────
  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorder, width: 1),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDivider({Color? color}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      height: 0.5,
      color: color ?? kBorder,
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required String label,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    Color iconColor = kGold,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          _buildIconContainer(icon, iconColor),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: kCream,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(
                          color: kMuted, fontSize: 12)),
                ],
              ],
            ),
          ),
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: kGold,
              activeTrackColor: const Color(0xFF3D2E10),
              inactiveThumbColor: kMuted,
              inactiveTrackColor: const Color(0xFF252528),
              trackOutlineColor:
                  WidgetStateProperty.all(Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavTile({
    required IconData icon,
    required String label,
    String? value,
    required VoidCallback onTap,
    Color iconColor = kGold,
    Color? labelColor,
    bool showChevron = true,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      splashColor: kBorder,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Row(
          children: [
            _buildIconContainer(icon, iconColor),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: labelColor ?? kCream,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1,
                ),
              ),
            ),
            if (value != null) ...[
              Text(value,
                  style: const TextStyle(color: kMuted, fontSize: 13)),
              const SizedBox(width: 6),
            ],
            if (showChevron)
              const Icon(Icons.chevron_right_rounded,
                  color: Color(0xFF4A4A55), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderTile({
    required IconData icon,
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
    Color iconColor = kGold,
  }) {
    final labels = ['S', 'M', 'L', 'XL'];
    final idx = ((value - 0.8) / 0.2).round().clamp(0, 3);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Column(
        children: [
          Row(
            children: [
              _buildIconContainer(icon, iconColor),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: kCream,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: kBorder,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  labels[idx],
                  style: const TextStyle(
                    color: kGold,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: kGold,
              inactiveTrackColor: kBorder,
              thumbColor: kGoldLight,
              overlayColor: kGold.withOpacity(0.15),
              trackHeight: 3,
              thumbShape:
                  const RoundSliderThumbShape(enabledThumbRadius: 7),
            ),
            child: Slider(
              value: value,
              min: 0.8,
              max: 1.4,
              divisions: 3,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconContainer(IconData icon, Color color) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.18), width: 1),
      ),
      child: Icon(icon, color: color, size: 19),
    );
  }
}
