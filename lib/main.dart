import 'package:flutter/material.dart';
import 'package:ojas_user/core/services/session_service.dart';
import 'package:provider/provider.dart';
import 'package:ojas_user/core/services/socket_service.dart';
import 'package:ojas_user/core/controllers/settings_controller.dart';
import 'package:ojas_user/core/controllers/home_controller.dart';
import 'package:ojas_user/core/theme/app_theme.dart';
import 'package:ojas_user/features/home/presentation/pages/home_page.dart';
import 'package:ojas_user/features/home/presentation/pages/features_page.dart';
import 'package:ojas_user/features/home/presentation/pages/deals_page.dart';
import 'package:ojas_user/features/home/presentation/pages/shop_page.dart';
import 'package:ojas_user/features/home/presentation/pages/blog_page.dart';
import 'package:ojas_user/features/home/presentation/pages/become_vendor_page.dart';
import 'package:ojas_user/features/auth/presentation/pages/auth_screen.dart';
import 'package:ojas_user/features/auth/presentation/pages/profile_screen.dart';
import 'package:ojas_user/features/auth/presentation/pages/welcome_screen.dart';
import 'package:ojas_user/features/home/presentation/pages/wishlist_page.dart';
import 'package:ojas_user/features/home/presentation/pages/orders_page.dart';
import 'package:ojas_user/features/home/presentation/pages/returns_refunds_page.dart';
import 'package:ojas_user/features/home/presentation/pages/terms_conditions_page.dart';
import 'package:ojas_user/features/home/presentation/pages/privacy_policy_page.dart';
import 'package:ojas_user/features/home/presentation/pages/contact_page.dart';
import 'package:ojas_user/features/auth/domain/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionService.instance.initSession();
  
  // Initialize Real-time services
  SocketService.instance.init();
  await SettingsController.instance.init();
  await HomeController.instance.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SettingsController.instance),
        ChangeNotifierProvider.value(value: HomeController.instance),
      ],
      child: ListenableBuilder(
        listenable: Listenable.merge([
          SettingsController.instance,
          HomeController.instance,
        ]),
      builder: (context, _) {
        final settings = SettingsController.instance.settings;
        
        final routes = {
          '/': (context) => const HomePage(),
          '/features': (context) => const FeaturesPage(),
          '/deals': (context) => const DealsPage(),
          '/shop': (context) => const ShopPage(),
          '/become-vendor': (context) => const BecomeVendorPage(),
          '/wishlist': (context) => const WishlistPage(),
          '/blog': (context) => const BlogPage(),
          '/orders': (context) => const OrdersPage(),
          '/returns': (context) => const ReturnsRefundsPage(),
          '/terms': (context) => const TermsConditionsPage(),
          '/privacy': (context) => const PrivacyPolicyPage(),
          '/contact': (context) => const ContactPage(),
          '/login': (context) => const AuthScreen(isInitialLogin: true),
          '/register': (context) => const AuthScreen(isInitialLogin: false),
          '/welcome': (context) {
            final args = ModalRoute.of(context)!.settings.arguments;
            final user = args is UserModel ? args : SessionService.instance.currentUser;
            if (user == null) return const AuthScreen(isInitialLogin: true);
            return WelcomeScreen(user: user);
          },
          '/profile': (context) {
            final args = ModalRoute.of(context)!.settings.arguments;
            final user = args is UserModel ? args : SessionService.instance.currentUser;
            if (user == null) return const AuthScreen(isInitialLogin: true);
            return ProfileScreen(user: user);
          },
        };

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: settings.marketplaceName,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark, // Keep it premium dark
          initialRoute: '/',
          routes: routes,
        );
      },
      ),
    );
  }
}
