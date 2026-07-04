import 'package:flutter/material.dart';

class AppColors {
  // Base Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  
  // Sophisticated Color Palette (Matching Logo)
  static const Color deepBlue = Color(0xFF1A237E); // Primary Dark Blue
  static const Color mediumBlue = Color(0xFF283593); // Medium Blue
  static const Color skyBlue = Color(0xFF00BCD4); // Bright Accent Blue
  static const Color cyan = Color(0xFF0097A7); // Cyan Accent
  static const Color darkGreen = Color(0xFF2E7D32); // Rich Green
  static const Color emerald = Color(0xFF43A047); // Bright Green
  static const Color gold = Color(0xFFFFC107); // Gold Accent
  static const Color amber = Color(0xFFFFB300); // Warm Amber
  
  // UI Colors
  static const Color background = Color(0xFFF8F9FF); // Soft Background
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFF0F4FF);
  static const Color border = Color(0xFFE0E7FF);
  static const Color borderLight = Color(0xFFEEF2FF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textLight = Color(0xFFCBD5E1);
  
  // Accent Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  static const Color cardPink = Color(0xFFFCE7F3);
  static const Color cardTeal = Color(0xFFCCFBF1);

  // Semantic Colors
  static const Color primary = deepBlue;
  static const Color secondary = darkGreen;
  static const Color accent = skyBlue;
  
  // Gradients (Sophisticated & Professional)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [deepBlue, mediumBlue, skyBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [darkGreen, emerald, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [skyBlue, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient heroGradient = LinearGradient(
    colors: [deepBlue, mediumBlue, skyBlue, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.3, 0.7, 1.0],
  );
  
  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [gold, amber],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Glassmorphism
  static const Color glassBackground = Color(0xCCFFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);
}

class AppTextStyles {
  static const TextStyle displayLarge = TextStyle(
    fontSize: 52,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -1.5,
    height: 1.1,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -1.0,
    height: 1.15,
  );
  
  static const TextStyle heading = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.2,
  );
  
  static const TextStyle subHeading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.3,
  );
  
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
    height: 1.35,
  );
  
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.6,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
    height: 1.4,
    letterSpacing: 0.3,
  );
  
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    height: 1.0,
  );
}

class AppBreakpoints {
  static const double mobile = 640;
  static const double tablet = 900;
  static const double desktop = 1200;
  static const double wide = 1440;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobile;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobile && width < desktop;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktop;

  static EdgeInsets pagePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= wide) {
      return const EdgeInsets.symmetric(horizontal: 80, vertical: 40);
    }
    if (width >= desktop) {
      return const EdgeInsets.symmetric(horizontal: 56, vertical: 32);
    }
    if (width >= mobile) {
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 28);
    }
    return const EdgeInsets.symmetric(horizontal: 24, vertical: 24);
  }

  static double contentWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= wide) return 1320;
    if (width >= desktop) return 1140;
    return width;
  }
}

class AppDecorations {
  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: AppColors.deepBlue.withValues(alpha: 0.10),
      blurRadius: 40,
      spreadRadius: 0,
      offset: const Offset(0, 16),
    ),
  ];
  
  static List<BoxShadow> mediumShadow = [
    BoxShadow(
      color: AppColors.deepBlue.withValues(alpha: 0.15),
      blurRadius: 50,
      spreadRadius: 0,
      offset: const Offset(0, 20),
    ),
  ];
  
  static List<BoxShadow> subtleShadow = [
    BoxShadow(
      color: AppColors.deepBlue.withValues(alpha: 0.06),
      blurRadius: 20,
      spreadRadius: 0,
      offset: const Offset(0, 8),
    ),
  ];
  
  static List<BoxShadow> innerShadow = [
    BoxShadow(
      color: AppColors.deepBlue.withValues(alpha: 0.05),
      blurRadius: 20,
      spreadRadius: 0,
      offset: const Offset(0, 4),
      blurStyle: BlurStyle.inner,
    ),
  ];
  
  static BoxDecoration card({
    Color color = AppColors.surface,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(32)),
    Border? border,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: borderRadius,
      border: border ?? Border.all(color: AppColors.border, width: 1.5),
      boxShadow: shadows ?? softShadow,
    );
  }
  
  static BoxDecoration glassCard({
    double blur = 20,
    Color color = AppColors.glassBackground,
    Color borderColor = AppColors.glassBorder,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(32)),
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: borderRadius,
      border: Border.all(color: borderColor, width: 1.5),
      boxShadow: softShadow,
    );
  }
  
  static BoxDecoration gradientCard({
    LinearGradient gradient = AppColors.primaryGradient,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(32)),
  }) {
    return BoxDecoration(
      gradient: gradient,
      borderRadius: borderRadius,
      boxShadow: mediumShadow,
    );
  }
}

class AppAnimations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration extraSlow = Duration(milliseconds: 800);
  
  static const Curve easeOut = Curves.easeOutCubic;
  static const Curve easeInOut = Curves.easeInOutCubic;
  static const Curve bounce = Curves.elasticOut;
  static const Curve decelerate = Curves.decelerate;
}
