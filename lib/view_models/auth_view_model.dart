import 'package:flutter/foundation.dart';

import '../services/firebase_services.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> signUp(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _authService.signUp(email, password);
      if (user != null) {
        await _firestoreService.saveUserDetails(user.uid, name, email);
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      throw ('Sign up error: $e');
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _authService.login(email, password);
      _isLoading = false;
      notifyListeners();
      return user != null;
    } catch (e) {
      throw ('Login error: $e');
    }
  }
}