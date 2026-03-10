import 'package:demo_app/screens/profile_screen.dart';
import 'package:demo_app/screens/settings_screen%20(1).dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─── Color Palette (same across all screens) ─────────────────────
const kBg        = Color(0xFF0A0A0B);
const kCard      = Color(0xFF1A1A1D);
const kBorder    = Color(0xFF2A2A2E);
const kGold      = Color(0xFFD4A853);
const kGoldLight = Color(0xFFE8C87A);
const kCream     = Color(0xFFF2EAD9);
const kMuted     = Color(0xFF8A8A8F);

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user     = FirebaseAuth.instance.currentUser;
    final username = user?.displayName ?? 'User';
    final email    = user?.email ?? 'No Email';
    final initials = username
        .trim()
        .split(' ')
        .take(2)
        .map((w) => w.isNotEmpty ? w[0].toUpperCase() : '')
        .join();

    return Drawer(
      backgroundColor: kBg,
      width: MediaQuery.of(context).size.width * 0.80,
      child: Column(
        children: [

          // ── Header ──────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1E1C18), Color(0xFF141416)],
              ),
              border: Border(
                bottom: BorderSide(color: kBorder, width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gold ring avatar
                Container(
                  padding: const EdgeInsets.all(2.5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [kGold, kGoldLight, kGold],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    width: 62,
                    height: 62,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF252320),
                    ),
                    child: Center(
                      child: Text(
                        initials.isEmpty ? 'U' : initials,
                        style: const TextStyle(
                          color: kGoldLight,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Name + PRO badge
                Row(
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        color: kCream,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFF8B6914), kGold]),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star_rounded,
                              color: kCream, size: 9),
                          SizedBox(width: 3),
                          Text('PRO',
                              style: TextStyle(
                                color: kCream,
                                fontSize: 8.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  email,
                  style: const TextStyle(color: kMuted, fontSize: 12.5),
                ),
              ],
            ),
          ),

          // ── Nav items ────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [

                _buildSectionLabel('Menu'),
                const SizedBox(height: 6),

                _DrawerTile(
                  icon: Icons.person_outline_rounded,
                  label: 'Profile',
                  iconColor: const Color(0xFF6B9EFF),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (_) => const ProfileScreen()));
                  },
                ),

                _DrawerTile(
                  icon: Icons.favorite_outline_rounded,
                  label: 'Favourites',
                  iconColor: const Color(0xFFFF6B9E),
                  onTap: () {},
                ),

                _DrawerTile(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  iconColor: kGold,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (_) => const SettingsScreen()));
                  },
                ),

                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(height: 0.5, color: kBorder),
                ),
                const SizedBox(height: 8),

                _buildSectionLabel('Account'),
                const SizedBox(height: 6),

                _DrawerTile(
                  icon: Icons.logout_rounded,
                  label: 'Logout',
                  iconColor: const Color(0xFFFF7262),
                  labelColor: const Color(0xFFFF7262),
                  onTap: () => _showLogoutDialog(context),
                ),
              ],
            ),
          ),

          // ── Footer ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.only(bottom: 28),
            child: Column(
              children: [
                Container(
                    width: 36, height: 0.5, color: kBorder),
                const SizedBox(height: 12),
                const Text(
                  'Version 3.4.1',
                  style: TextStyle(color: Color(0xFF555560), fontSize: 11.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 2),
      child: Row(
        children: [
          Container(
            width: 3, height: 12,
            decoration: BoxDecoration(
              color: kGold, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 8),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: kMuted,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: const Color(0xFF1A1A1D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: kBorder),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 52, height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7262).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: const Color(0xFFFF7262).withOpacity(0.2)),
                ),
                child: const Icon(Icons.logout_rounded,
                    color: Color(0xFFFF7262), size: 24),
              ),
              const SizedBox(height: 16),
              const Text(
                'Sign Out',
                style: TextStyle(
                  color: kCream,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Georgia',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Are you sure you want to sign out?',
                textAlign: TextAlign.center,
                style: TextStyle(color: kMuted, fontSize: 13.5),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: kMuted,
                          side: const BorderSide(color: kBorder),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF7262),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sign Out',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Drawer Tile ──────────────────────────────────────────────────
class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color? labelColor;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onTap,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: kBorder,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 36, height: 36,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: iconColor.withOpacity(0.2), width: 1),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 14),
              Text(
                label,
                style: TextStyle(
                  color: labelColor ?? kCream,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}