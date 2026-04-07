import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/shell_screen.dart';
import 'package:ojas_user/features/auth/domain/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ShellScreen(
      child: Container(
        color: const Color(0xFFF8FAFC), // Light uniform background
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: SizedBox(
            width: 1000,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Section
                InkWell(
                  onTap: () => Navigator.of(context).pushReplacementNamed('/'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back, size: 16, color: Color(0xFF64748B)),
                      const SizedBox(width: 8),
                      Text('Back', style: GoogleFonts.inter(color: const Color(0xFF64748B), fontSize: 14)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'My Profile',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Manage your account information and preferences',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF64748B),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 32),

                // Main Content Layout
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column (Profile Card)
                    SizedBox(
                      width: 280,
                      child: _buildProfileCard(context),
                    ),
                    const SizedBox(width: 24),
                    
                    // Right Column (Info Lists)
                    Expanded(
                      child: Column(
                        children: [
                          _buildPersonalInfoCard(),
                          const SizedBox(height: 24),
                          _buildAccountInfoCard(),
                          const SizedBox(height: 24),
                          _buildQuickActionsCard(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60), // bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: const Color(0xFFF1F5F9),
            child: const Icon(Icons.person, size: 50, color: Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 20),
          Text(
            user.name,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'User',
            style: GoogleFonts.inter(
              color: const Color(0xFF64748B),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit_outlined, size: 18),
              label: Text('Edit Profile', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE91E63),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFFCA5A5)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Logout',
                style: GoogleFonts.inter(
                  color: const Color(0xFFE11D48),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoCard() {
    return _buildSectionCard(
      title: 'Personal Information',
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoField('Full Name', Icons.person_outline, user.name),
                const SizedBox(height: 20),
                _buildInfoField('Email Address', Icons.mail_outline, user.email),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoField('Phone Number', Icons.phone_outlined, user.mobile),
                const SizedBox(height: 20),
                _buildInfoField('Account Type', Icons.shield_outlined, 'User'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfoCard() {
    return _buildSectionCard(
      title: 'Account Information',
      child: Row(
        children: [
          Expanded(
            child: _buildInfoField('Member Since', Icons.calendar_today_outlined, 'November 8, 2025'),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _buildInfoField('Account Status', Icons.shield_outlined, 'Unverified', valueColor: const Color(0xFFD97706)),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    return _buildSectionCard(
      title: 'Quick Actions',
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionItem(
              icon: Icons.receipt_long_outlined,
              iconBgColor: const Color(0xFFEFF6FF),
              iconColor: const Color(0xFF3B82F6),
              title: 'My Orders',
              subtitle: 'View order history',
              onTap: () {},
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _buildQuickActionItem(
              icon: Icons.favorite_border_outlined,
              iconBgColor: const Color(0xFFFCE7F3),
              iconColor: const Color(0xFFEC4899),
              title: 'Wishlist',
              subtitle: 'Saved items',
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, IconData icon, String value, {Color valueColor = const Color(0xFF1E293B)}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF64748B),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF94A3B8)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  value,
                  style: GoogleFonts.inter(
                    color: valueColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE2E8F0)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
