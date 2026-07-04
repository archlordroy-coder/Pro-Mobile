import 'package:flutter/material.dart';
import '../constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: _buildProfileView(),
        ),
      ),
    );
  }

  Widget _buildProfileView() {
    return SingleChildScrollView(
      padding: AppBreakpoints.pagePadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: AppBreakpoints.contentWidth(context)),
          child: Column(
            children: [
          const SizedBox(height: 40),
          const CircleAvatar(
            radius: 60,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Text(
            'Visiteur',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          const Text(
            'Connectez-vous pour accéder à votre profil',
            style:
                TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
          const SizedBox(height: 40),
          _buildProfileItem(Icons.history, 'Historique des commandes'),
          _buildProfileItem(
              Icons.notifications_outlined, 'Paramètres des notifications'),
          _buildProfileItem(Icons.help_outline, 'Aide & Support'),
          _buildProfileItem(Icons.info_outline, 'À propos'),
        ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title,
      {Color? color, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: color ?? AppColors.primary, size: 28),
        title: Text(title,
            style: TextStyle(
                color: color ?? AppColors.textPrimary,
                fontWeight: FontWeight.w500,
                fontSize: 16)),
        trailing:
            onTap != null ? const Icon(Icons.chevron_right, size: 24) : null,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}
