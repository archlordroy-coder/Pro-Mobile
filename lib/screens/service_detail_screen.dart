import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';
import '../models/service.dart';
import '../models/business_info.dart';

class ServiceDetailScreen extends StatelessWidget {
  final Service service;
  const ServiceDetailScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
                child: Center(
                  child: Icon(
                    service.icon,
                    size: 120,
                    color: AppColors.white.withValues(alpha: 0.9),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppBreakpoints.pagePadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    service.title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    service.description,
                    style: AppTextStyles.body.copyWith(fontSize: 18, height: 1.6),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Fonctionnalités',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...service.features.map((feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                feature,
                                style: AppTextStyles.body.copyWith(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () => _contactForService(context),
                      icon: const Icon(Icons.whatsapp, size: 24),
                      label: const Text(
                        'Contacter pour ce service',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _contactForService(BuildContext context) async {
    const info = BusinessInfo();
    final String message =
        "Bonjour Ets PRO INFORMATIQUE, je suis intéressé par le service suivant : ${service.title}. Pouvons-nous discuter des modalités ?";
    final String url =
        "https://wa.me/${info.whatsapp.replaceAll(' ', '').replaceAll('+', '').replaceAll('(', '').replaceAll(')', '')}?text=${Uri.encodeComponent(message)}";

    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Impossible d\'ouvrir WhatsApp')),
        );
      }
    }
  }
}
