import 'package:flutter/material.dart';
import '../constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Paramètres',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('Compte'),
          _buildSettingItem(
            icon: Icons.person_outline,
            title: 'Informations personnelles',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.security_outlined,
            title: 'Sécurité',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Préférences'),
          _buildSettingItem(
            icon: Icons.language_outlined,
            title: 'Langue',
            trailing: const Text('Français'),
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.dark_mode_outlined,
            title: 'Mode sombre',
            trailing: Switch(
              value: false,
              onChanged: (value) {},
            ),
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.text_fields_outlined,
            title: 'Taille du texte',
            trailing: const Text('Moyen'),
            onTap: () {},
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Support'),
          _buildSettingItem(
            icon: Icons.help_outline,
            title: 'Centre d\'aide',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.info_outline,
            title: 'À propos',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.rate_review_outlined,
            title: 'Noter l\'application',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('Légal'),
          _buildSettingItem(
            icon: Icons.description_outlined,
            title: 'Conditions d\'utilisation',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.privacy_tip_outlined,
            title: 'Politique de confidentialité',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          _buildSettingItem(
            icon: Icons.logout,
            title: 'Déconnexion',
            titleColor: AppColors.cardPink,
            iconColor: AppColors.cardPink,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          const Text(
            'Version 1.0.0',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textLight,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    Color? titleColor,
    Color? iconColor,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: iconColor ?? AppColors.primary,
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: titleColor ?? AppColors.textPrimary,
          ),
        ),
        trailing: trailing ?? const Icon(Icons.chevron_right, color: AppColors.textLight),
      ),
    );
  }
}
