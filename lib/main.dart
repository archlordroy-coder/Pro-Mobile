import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'screens/main_screen.dart';
import 'screens/services_screen.dart';
import 'screens/service_detail_screen.dart';
import 'screens/products_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/search_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/auth_screen.dart';
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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case '/auth':
            return MaterialPageRoute(builder: (_) => const AuthScreen());
          case '/main':
            return MaterialPageRoute(builder: (_) => const MainScreen());
          case '/services':
            return MaterialPageRoute(builder: (_) => const ServicesScreen());
          case '/products':
            return MaterialPageRoute(builder: (_) => const ProductsScreen());
          case '/contact':
            return MaterialPageRoute(builder: (_) => const ContactScreen());
          case '/profile':
            return MaterialPageRoute(builder: (_) => const ProfileScreen());
          case '/settings':
            return MaterialPageRoute(builder: (_) => const SettingsScreen());
          case '/search':
            return MaterialPageRoute(builder: (_) => const SearchScreen());
          case '/cart':
            return MaterialPageRoute(builder: (_) => const CartScreen());
          case '/admin_login':
            return MaterialPageRoute(builder: (_) => const AdminLoginScreen());
          case '/admin_panel':
            return MaterialPageRoute(builder: (_) => const AdminPanelScreen());
          case '/cyber_cafe':
            return MaterialPageRoute(builder: (_) => const CyberCafeScreen());
          case '/service_detail':
            final service = settings.arguments;
            if (service != null) {
              return MaterialPageRoute(
                builder: (_) => ServiceDetailScreen(service: service as dynamic),
              );
            }
            return MaterialPageRoute(builder: (_) => const MainScreen());
          case '/product_detail':
            final product = settings.arguments;
            if (product != null) {
              return MaterialPageRoute(
                builder: (_) => ProductDetailScreen(product: product as dynamic),
              );
            }
            return MaterialPageRoute(builder: (_) => const MainScreen());
          default:
            return MaterialPageRoute(builder: (_) => const MainScreen());
        }
      },
    );
  }
}
