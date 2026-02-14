import 'package:aceate/core/theme/app_theme.dart';
import 'package:aceate/features/djiwa_ai_page.dart';
import 'package:aceate/features/home_page.dart';
import 'package:aceate/features/login_page.dart';
import 'package:aceate/features/main_wrapper.dart';
import 'package:aceate/features/otp_page.dart';
import 'package:aceate/features/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/routes/app_route.dart';
import 'features/boarding/boarding.dart';
import 'features/splash/splash_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load environment variables from .env (SUPABASE_URL and SUPABASE_ANON_KEY)
  await dotenv.load(fileName: '.env');

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

  if (supabaseUrl == null || supabaseAnonKey == null) {
    // Fail fast in development — these must be provided.
    throw Exception('SUPABASE_URL and SUPABASE_ANON_KEY must be set in .env');
  }

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aceate',
      theme: AppTheme.lightTheme,

      home: const SplashWrapper(),

      routes: {
        AppRoutes.onboarding: (context) => const OnBoarding(),
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.register: (context) => const RegisterPage(),
        AppRoutes.otp: (context) => const OtpPage(),
        AppRoutes.home: (context) => const MainWrapper(),
        AppRoutes.djiwaAi: (context) => const DjiwaAiPage(),
      },
    );
  }
}
