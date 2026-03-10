import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../provider/task_provder.dart';

// ─── Color Palette (same as Settings) ────────────────────────────
const kBg = Color(0xFF0A0A0B);
const kCard = Color(0xFF1A1A1D);
const kBorder = Color(0xFF2A2A2E);
const kGold = Color(0xFFD4A853);
const kGoldLight = Color(0xFFE8C87A);
const kCream = Color(0xFFF2EAD9);
const kMuted = Color(0xFF8A8A8F);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));

    final user = FirebaseAuth.instance.currentUser;
    final username = user?.displayName ?? "User";
    final email = user?.email ?? "No Email";

    final tasks = context.watch<TaskProvider>().tasks;
    final total = tasks.length;
    final completed = tasks.where((t) => t.isComplete).length;
    final pending = total - completed;

    // Initials from username
    final initials = username
        .trim()
        .split(' ')
        .take(2)
        .map((w) => w.isNotEmpty ? w[0].toUpperCase() : '')
        .join();

    return Scaffold(
      backgroundColor: kBg,
      body: FadeTransition(
        opacity: animation,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── App Bar ──────────────────────────────────────────
            SliverAppBar(
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
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                title: const Text(
                  'Profile',
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
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 8),

                  // ── Avatar Card ───────────────────────────────
                  ScaleTransition(
                    scale: animation,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF1E1C18), Color(0xFF141416)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kBorder, width: 1),
                      ),
                      child: Column(
                        children: [
                          // Gold ring avatar
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [kGold, kGoldLight, kGold],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Container(
                              width: 90,
                              height: 90,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF252320),
                              ),
                              child: Center(
                                child: Text(
                                  initials.isEmpty ? 'U' : initials,
                                  style: const TextStyle(
                                    color: kGoldLight,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Name + badge
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                username,
                                style: const TextStyle(
                                  color: kCream,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const SizedBox(width: 10),
                              _buildPremiumBadge(),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            email,
                            style: const TextStyle(
                              color: kMuted,
                              fontSize: 13,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Stats ─────────────────────────────────────
                  _buildSectionLabel('Task Overview'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _statCard('Total', total, const Color(0xFF6B9EFF), Icons.list_rounded)),
                      const SizedBox(width: 12),
                      Expanded(child: _statCard('Done', completed, const Color(0xFF5DC896), Icons.check_circle_outline_rounded)),
                      const SizedBox(width: 12),
                      Expanded(child: _statCard('Pending', pending, const Color(0xFFFF9F5B), Icons.hourglass_empty_rounded)),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // ── Details ───────────────────────────────────
                  _buildSectionLabel('Details'),
                  const SizedBox(height: 12),
                  _buildCard([
                    _buildInfoTile(
                      icon: Icons.phone_outlined,
                      label: 'Phone',
                      value: '+91 9876543210',
                      iconColor: const Color(0xFF5DC896),
                    ),
                    _buildDivider(),
                    _buildInfoTile(
                      icon: Icons.location_on_outlined,
                      label: 'Location',
                      value: 'Kerala, India',
                      iconColor: const Color(0xFFFF9F5B),
                    ),
                    _buildDivider(),
                    _buildInfoTile(
                      icon: Icons.work_outline_rounded,
                      label: 'Profession',
                      value: 'Flutter Developer',
                      iconColor: const Color(0xFFB88EFF),
                    ),
                    _buildDivider(),
                    _buildInfoTile(
                      icon: Icons.info_outline_rounded,
                      label: 'About',
                      value: 'Todo App User',
                      iconColor: const Color(0xFF6B9EFF),
                    ),
                  ]),

                  const SizedBox(height: 28),

                  // ── Actions ───────────────────────────────────
                  _buildSectionLabel('Account'),
                  const SizedBox(height: 12),
                  _buildCard([
                    _buildNavTile(
                      icon: Icons.edit_outlined,
                      label: 'Edit Profile',
                      iconColor: kGold,
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildNavTile(
                      icon: Icons.logout_rounded,
                      label: 'Sign Out',
                      iconColor: const Color(0xFFFF7262),
                      labelColor: const Color(0xFFFF7262),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) Navigator.pop(context);
                      },
                    ),
                  ]),

                  const SizedBox(height: 40),

                  // ── Version ───────────────────────────────────
                  Center(
                    child: Column(
                      children: [
                        Container(width: 36, height: 1, color: kBorder),
                        const SizedBox(height: 14),
                        const Text(
                          'Version 3.4.1 · Build 2024.12',
                          style: TextStyle(color: Color(0xFF555560), fontSize: 12, letterSpacing: 0.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Shared Builders ────────────────────────────────────────────

  Widget _buildPremiumBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF8B6914), kGold]),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, color: kCream, size: 10),
          SizedBox(width: 3),
          Text('PRO',
              style: TextStyle(
                  color: kCream,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2)),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Container(
            width: 3, height: 14,
            decoration: BoxDecoration(color: kGold, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 10),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
                color: kMuted, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 2.0),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String title, int value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kBorder, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withOpacity(0.2), width: 1),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            value.toString(),
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: color),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: kMuted, fontSize: 11.5)),
        ],
      ),
    );
  }

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

  Widget _buildDivider() {
    return Container(margin: const EdgeInsets.symmetric(horizontal: 18), height: 0.5, color: kBorder);
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    Color iconColor = kGold,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          _buildIconBox(icon, iconColor),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(color: kMuted, fontSize: 11.5, letterSpacing: 0.3)),
                const SizedBox(height: 3),
                Text(value,
                    style: const TextStyle(color: kCream, fontSize: 14.5, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color iconColor = kGold,
    Color? labelColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      splashColor: kBorder,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Row(
          children: [
            _buildIconBox(icon, iconColor),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label,
                  style: TextStyle(
                      color: labelColor ?? kCream,
                      fontSize: 15,
                      fontWeight: FontWeight.w500)),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF4A4A55), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBox(IconData icon, Color color) {
    return Container(
      width: 38, height: 38,
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.18), width: 1),
      ),
      child: Icon(icon, color: color, size: 19),
    );
  }
}
