import 'package:assignment/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static const String appName = 'Comments App';
  static const String loginTitle = 'Login';
  static const String signUpTitle = 'Sign Up';
  static const String homeTitle = 'Comments';
}

String maskEmail(String email) {
  final remoteConfigService = RemoteConfigService();

  if (remoteConfigService.shouldMaskEmail) {
    final parts = email.split('@');
    if (parts.length == 2) {
      String name = parts[0];
      String domain = parts[1];
      if (name.length > 3) {
        name = name.substring(0, 3) + '*' * (name.length - 3);
      }
      return '$name@$domain';
    }
  }
  return email;
}

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF0C54BE),
    scaffoldBackgroundColor: const Color(0xFFF5F5FA),
    textTheme: GoogleFonts.poppinsTextTheme(),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1E65CF),
    scaffoldBackgroundColor: const Color(0xFF1C2331),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
  );
}

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadThemePreference();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveThemePreference();
    notifyListeners();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> _saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _themeMode == ThemeMode.dark);
  }
}