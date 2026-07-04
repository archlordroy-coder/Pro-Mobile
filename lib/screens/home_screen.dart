import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../constants.dart';
import '../providers/app_provider.dart';
import '../models/promotion.dart';
import 'product_detail_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  String _selectedCategory = 'Tout';
  final TextEditingController _searchController = TextEditingController();

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
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final isMobile = AppBreakpoints.isMobile(context);
    final isTablet = AppBreakpoints.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => appProvider.fetchData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: AppBreakpoints.pagePadding(context),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: AppBreakpoints.contentWidth(context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _buildTopBar(context, isMobile),
                      ),
                    ),
                    const SizedBox(height: 40),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _buildHeroSection(isMobile),
                      ),
                    ),
                    const SizedBox(height: 32),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _buildSearchBar(),
                      ),
                    ),
                    const SizedBox(height: 32),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _buildCategoryChips(),
                      ),
                    ),
                    const SizedBox(height: 32),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _buildSectionHeader('Arrivages Récents'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _buildIllustrationGrid(
                            context, appProvider, isMobile, isTablet),
                      ),
                    ),
                    const SizedBox(height: 40),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _buildPromotionBanner(),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (isMobile)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: AppDecorations.card(
              borderRadius: BorderRadius.circular(20),
              shadows: AppDecorations.subtleShadow,
            ),
            child: const Icon(Icons.menu_rounded, color: AppColors.primary, size: 24),
          )
        else
          const SizedBox.shrink(),
        const Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_rounded, color: AppColors.primary, size: 18),
              SizedBox(width: 6),
              Text(
                'Bafoussam, Akwa',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(16),
            boxShadow: AppDecorations.softShadow,
          ),
          child: IconButton(
            icon: const Icon(Icons.person_outline_rounded, color: AppColors.white, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection(bool isMobile) {
    return Container(
      width: double.infinity,
      decoration: AppDecorations.gradientCard(
        gradient: AppColors.heroGradient,
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 28 : 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '✨ Nouveau 2025',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Explorez nos Solutions IT',
              style: TextStyle(
                fontSize: isMobile ? 32 : 44,
                fontWeight: FontWeight.w800,
                color: AppColors.white,
                height: 1.1,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Matériel informatique, maintenance, impression et bien plus!',
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w500,
                color: AppColors.white.withValues(alpha: 0.85),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                        child: Text(
                          'Découvrir',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: AppDecorations.card(
        shadows: AppDecorations.softShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.search_rounded,
                color: AppColors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  hintText: 'Rechercher un produit ou service...',
                  hintStyle: TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    final categories = ['Tout', 'Impression', 'Matériel', 'Design'];
    final gradients = [
      AppColors.primaryGradient,
      AppColors.accentGradient,
      const LinearGradient(colors: [Color(0xFF63D2FF), Color(0xFF51B5FF)]),
      const LinearGradient(colors: [Color(0xFFFFB35C), Color(0xFFFF9800)]),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          final label = categories[index];
          final gradient = gradients[index];
          final isActive = _selectedCategory == label;
          
          return Padding(
            padding: EdgeInsets.only(right: index < categories.length - 1 ? 12 : 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = label;
                });
              },
              child: AnimatedContainer(
                duration: AppAnimations.medium,
                curve: AppAnimations.easeOut,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                decoration: BoxDecoration(
                  gradient: isActive ? gradient : null,
                  color: isActive ? null : AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isActive
                        ? Colors.transparent
                        : AppColors.border,
                    width: 1.5,
                  ),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: gradient.colors[1].withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          )
                        ]
                      : null,
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: isActive ? AppColors.white : AppColors.textSecondary,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(16),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  'Voir tout',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIllustrationGrid(
      BuildContext context, AppProvider provider, bool isMobile, bool isTablet) {
    if (provider.isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(60),
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    // Filtrage des produits
    var filteredProducts = provider.products;

    if (_selectedCategory != 'Tout') {
      filteredProducts = filteredProducts
          .where((p) => p.category
              .toLowerCase()
              .contains(_selectedCategory.toLowerCase()))
          .toList();
    }

    if (_searchController.text.isNotEmpty) {
      final searchLower = _searchController.text.toLowerCase();
      filteredProducts = filteredProducts
          .where((p) =>
              p.name.toLowerCase().contains(searchLower) ||
              (p.description?.toLowerCase().contains(searchLower) ?? false))
          .toList();
    }

    if (filteredProducts.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(60),
        decoration: AppDecorations.card(),
        child: const Column(
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 80,
              color: AppColors.textLight,
            ),
            SizedBox(height: 20),
            Text(
              'Aucun produit trouvé',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    final displayProducts = filteredProducts.length > 4
        ? filteredProducts.sublist(0, 4)
        : filteredProducts;

    int crossAxisCount = isMobile ? 2 : (isTablet ? 3 : 4);
    double childAspectRatio = isMobile ? 0.7 : 0.75;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: displayProducts.length,
      itemBuilder: (context, index) {
        final product = displayProducts[index];
        final delay = Duration(milliseconds: index * 100);
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: AppAnimations.slow + delay,
          curve: AppAnimations.easeOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: 0.85 + (value * 0.15),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(product: product),
              ),
            ),
            child: _buildProductCard(product),
          ),
        );
      },
    );
  }

  Widget _buildProductCard(dynamic product) {
    return Container(
      decoration: AppDecorations.card(
        shadows: AppDecorations.subtleShadow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: 'product_${product.id}',
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceElevated,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.borderLight,
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 48,
                          color: AppColors.textLight,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.category,
              style: const TextStyle(
                color: AppColors.textTertiary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                product.priceDisplay,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionBanner() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1.0,
        autoPlayInterval: const Duration(seconds: 6),
      ),
      items: proPromotions.map((promo) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColors.secondaryGradient,
            borderRadius: BorderRadius.circular(32),
            image: DecorationImage(
              image: NetworkImage(promo.imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                AppColors.primary.withValues(alpha: 0.85),
                BlendMode.darken,
              ),
            ),
            boxShadow: AppDecorations.mediumShadow,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '🎉 Promo Spéciale',
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: 0.95),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  promo.title,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  promo.description,
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.85),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        child: Text(
                          'En savoir plus',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
          ),
        );
      }).toList(),
    );
  }
}
