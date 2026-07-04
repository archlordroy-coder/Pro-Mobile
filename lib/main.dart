import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'screens/home_screen.dart';
import 'screens/services_screen.dart';
import 'screens/products_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/admin_login_screen.dart';
import 'screens/admin_panel_screen.dart';
import 'screens/cyber_cafe_screen.dart';
import 'screens/splash_screen.dart';
import 'providers/app_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: const ProInformatiqueApp(),
    ),
  );
}

class ProInformatiqueApp extends StatelessWidget {
  const ProInformatiqueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ets PRO INFORMATIQUE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          tertiary: AppColors.accent,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
            side: const BorderSide(color: AppColors.border, width: 1.5),
          ),
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          buttonColor: AppColors.primary,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/services': (context) => const ServicesScreen(),
        '/products': (context) => const ProductsScreen(),
        '/contact': (context) => const ContactScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/admin_login': (context) => const AdminLoginScreen(),
        '/admin_panel': (context) => const AdminPanelScreen(),
        '/cyber_cafe': (context) => const CyberCafeScreen(),
      },
    );
  }
}
