import 'package:shared_preferences/shared_preferences.dart';

class OnboardingManager {
  static const String _onboardingKey = 'hasSeenOnboarding';

  /// Check if user has already seen onboarding
  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  /// Mark onboarding as seen
  static Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }
}
