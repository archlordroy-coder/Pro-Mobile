import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/app_provider.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppAnimations.extraSlow,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: AppAnimations.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: AppAnimations.easeOut),
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
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: kIsWeb
          ? null
          : AppBar(
              backgroundColor: AppColors.background,
              elevation: 0,
              title: const Text(
                'Nos Services',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              centerTitle: true,
            ),
      body: appProvider.isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : RefreshIndicator(
              onRefresh: () => appProvider.fetchData(),
              child: SingleChildScrollView(
                padding: AppBreakpoints.pagePadding(context),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: AppBreakpoints.contentWidth(context)),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            const Text(
                              'Nos Services',
                              style: AppTextStyles.heading,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Des solutions IT complètes et professionnelles',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 32),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: appProvider.services.length,
                              itemBuilder: (context, index) {
                                final service = appProvider.services[index];
                                final delay = Duration(milliseconds: index * 100);
                                return TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0, end: 1),
                                  duration: AppAnimations.slow + delay,
                                  curve: AppAnimations.easeOut,
                                  builder: (context, value, child) {
                                    return Transform.translate(
                                      offset: Offset(0, (1 - value) * 30),
                                      child: Opacity(
                                        opacity: value,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: _buildServiceCard(service, index),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildServiceCard(dynamic service, int index) {
    final gradients = [
      AppColors.primaryGradient,
      AppColors.accentGradient,
      AppColors.secondaryGradient,
    ];
    final gradient = gradients[index % gradients.length];

    return Container(
      decoration: AppDecorations.card(
        shadows: AppDecorations.softShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppDecorations.subtleShadow,
                  ),
                  child: Icon(
                    service.icon,
                    color: AppColors.white,
                    size: 36,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Text(
                    service.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              service.description,
              style: AppTextStyles.body.copyWith(fontSize: 16, height: 1.7),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: service.features.map<Widget>((feature) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    feature,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
