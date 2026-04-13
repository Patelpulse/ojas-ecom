import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojas_user/core/widgets/shell_screen.dart';
import 'package:ojas_user/core/services/session_service.dart';
import 'package:ojas_user/features/auth/domain/models/user_model.dart';
import 'package:ojas_user/core/utils/responsive.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return ShellScreen(
      child: Container(
        color: const Color(0xFFF8FAFC),
        padding: EdgeInsets.symmetric(vertical: isMobile ? 24 : 40, horizontal: isMobile ? 12 : 24),
        child: Center(
          child: SizedBox(
            width: isMobile ? double.infinity : 1000,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Header Section
                  _buildHeader(context),
                  const SizedBox(height: 32),

                  // Main Content Layout
                  if (isMobile)
                    Column(
                      children: [
                        _buildProfileCard(context),
                        const SizedBox(height: 24),
                        _buildPersonalInfoCard(isMobile),
                        const SizedBox(height: 24),
                        _buildAccountInfoCard(isMobile),
                        const SizedBox(height: 24),
                        _buildQuickActionsCard(isMobile),
                      ],
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column
                        SizedBox(
                          width: 280,
                          child: _buildProfileCard(context),
                        ),
                        const SizedBox(width: 24),
                        
                        // Right Column
                        Expanded(
                          child: Column(
                            children: [
                              _buildPersonalInfoCard(isMobile),
                              const SizedBox(height: 24),
                              _buildAccountInfoCard(isMobile),
                              const SizedBox(height: 24),
                              _buildQuickActionsCard(isMobile),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
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
              onPressed: () {
                SessionService.instance.setUser(null);
                Navigator.of(context).pushReplacementNamed('/');
              },
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

  Widget _buildPersonalInfoCard(bool isMobile) {
    final nameField = _buildInfoField('Full Name', Icons.person_outline, user.name);
    final emailField = _buildInfoField('Email Address', Icons.mail_outline, user.email);
    final phoneField = _buildInfoField('Phone Number', Icons.phone_outlined, user.mobile);
    final accountTypeField = _buildInfoField('Account Type', Icons.shield_outlined, user.role.toUpperCase());

    return _buildSectionCard(
      title: 'Personal Information',
      isMobile: isMobile,
      child: isMobile 
        ? Column(
            children: [
              nameField,
              const SizedBox(height: 16),
              emailField,
              const SizedBox(height: 16),
              phoneField,
              const SizedBox(height: 16),
              accountTypeField,
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    nameField,
                    const SizedBox(height: 20),
                    emailField,
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    phoneField,
                    const SizedBox(height: 20),
                    accountTypeField,
                  ],
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildAccountInfoCard(bool isMobile) {
    final memberSinceField = _buildInfoField('Member Since', Icons.calendar_today_outlined, 'November 8, 2025');
    final accountStatusField = _buildInfoField('Account Status', Icons.shield_outlined, 'Unverified', valueColor: const Color(0xFFD97706));

    return _buildSectionCard(
      title: 'Account Information',
      isMobile: isMobile,
      child: isMobile 
        ? Column(
            children: [
              memberSinceField,
              const SizedBox(height: 16),
              accountStatusField,
            ],
          )
        : Row(
            children: [
              Expanded(child: memberSinceField),
              const SizedBox(width: 24),
              Expanded(child: accountStatusField),
            ],
          ),
    );
  }

  Widget _buildQuickActionsCard(bool isMobile) {
    final ordersAction = _buildQuickActionItem(
      icon: Icons.receipt_long_outlined,
      iconBgColor: const Color(0xFFEFF6FF),
      iconColor: const Color(0xFF3B82F6),
      title: 'My Orders',
      subtitle: 'View order history',
      onTap: () {},
    );
    
    final wishlistAction = _buildQuickActionItem(
      icon: Icons.favorite_border_outlined,
      iconBgColor: const Color(0xFFFCE7F3),
      iconColor: const Color(0xFFEC4899),
      title: 'Wishlist',
      subtitle: 'Saved items',
      onTap: () {},
    );

    return _buildSectionCard(
      title: 'Quick Actions',
      isMobile: isMobile,
      child: isMobile 
        ? Column(
            children: [
              ordersAction,
              const SizedBox(height: 16),
              wishlistAction,
            ],
          )
        : Row(
            children: [
              Expanded(child: ordersAction),
              const SizedBox(width: 24),
              Expanded(child: wishlistAction),
            ],
          ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child, required bool isMobile}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 32),
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
