import 'package:flutter/material.dart';
import 'package:ojas_user/features/auth/domain/models/user_model.dart';
import 'package:ojas_user/features/auth/application/auth_service.dart';

class SessionService extends ChangeNotifier {
  static final SessionService _instance = SessionService._internal();
  static SessionService get instance => _instance;

  SessionService._internal();

  final ValueNotifier<UserModel?> userNotifier = ValueNotifier<UserModel?>(null);
  final ValueNotifier<bool> isInitializedNotifier = ValueNotifier<bool>(false);

  UserModel? get currentUser => userNotifier.value;
  bool get isLoggedIn => userNotifier.value != null;
  bool get isInitialized => isInitializedNotifier.value;

  void setUser(UserModel? user) {
    userNotifier.value = user;
    notifyListeners();
  }

  Future<void> initSession() async {
    try {
      final authService = AuthService();
      final user = await authService.getCurrentUser();
      userNotifier.value = user;
    } catch (e) {
      userNotifier.value = null;
    } finally {
      isInitializedNotifier.value = true;
      notifyListeners();
    }
  }

  void logout() {
    userNotifier.value = null;
    notifyListeners();
  }
}
