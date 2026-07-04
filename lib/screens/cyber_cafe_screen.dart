import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/cyber_session.dart';
import '../providers/app_provider.dart';

class CyberCafeScreen extends StatefulWidget {
  const CyberCafeScreen({super.key});

  @override
  State<CyberCafeScreen> createState() => _CyberCafeScreenState();
}

class _CyberCafeScreenState extends State<CyberCafeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _slideAnimation = Tween<Offset>(
            begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: appProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: AppBreakpoints.pagePadding(context),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: AppBreakpoints.contentWidth(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: _buildHeader(),
                          ),
                        ),
                        const SizedBox(height: 32),
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: _buildTicketsGrid(appProvider.cyberTickets),
                          ),
                        ),
                        const SizedBox(height: 32),
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: _buildComputersSection(appProvider.computers),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.computer, size: 56, color: Colors.white),
          SizedBox(height: 16),
          Text(
            'Cyber Café',
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'Accès internet haut débit • Ordinateurs modernes • Impression & numérisation',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketsGrid(List<CyberTicket> tickets) {
    int crossAxisCount = 2;
    if (AppBreakpoints.isDesktop(context)) {
      crossAxisCount = 4;
    } else if (AppBreakpoints.isTablet(context)) {
      crossAxisCount = 3;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nos Tarifs',
          style: AppTextStyles.heading,
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.85,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: tickets.length,
          itemBuilder: (context, index) {
            final ticket = tickets[index];
            return Container(
              decoration: AppDecorations.card(
                color: index % 2 == 0 ? AppColors.cardTeal : AppColors.cardPink,
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.timer, color: AppColors.primary),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    ticket.duration,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${ticket.price} FCFA',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildComputersSection(List<Computer> computers) {
    final availableCount = computers.where((c) => c.isAvailable).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Disponibilité',
              style: AppTextStyles.heading,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: availableCount > 0 ? AppColors.cardTeal : AppColors.cardPink,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$availableCount / ${computers.length} Libres',
                style: TextStyle(
                  color: availableCount > 0 ? Colors.teal[700] : Colors.red[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: computers.length,
          itemBuilder: (context, index) {
            final computer = computers[index];
            return Container(
              decoration: BoxDecoration(
                color: computer.isAvailable
                    ? AppColors.cardTeal.withValues(alpha: 0.5)
                    : AppColors.textSecondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: computer.isAvailable ? AppColors.cardTeal : AppColors.cardPink,
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.computer,
                  color: computer.isAvailable ? AppColors.cardTeal : AppColors.cardPink,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
