import 'package:flutter/material.dart';
import 'package:ojas_user/features/auth/domain/models/user_model.dart';
import 'package:ojas_user/features/auth/application/auth_service.dart';
import 'package:ojas_user/features/cart/application/cart_controller.dart';
import 'package:ojas_user/core/controllers/wishlist_controller.dart';

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
    if (user == null) {
      CartController.instance.clear();
      WishlistController.instance.fetchWishlist(); // Will clear since token is null
    } else {
      WishlistController.instance.fetchWishlist();
    }
    notifyListeners();
  }

  Future<void> initSession() async {
    try {
      final authService = AuthService();
      final user = await authService.getCurrentUser();
      userNotifier.value = user;
      
      if (user != null) {
        await CartController.instance.loadCart();
        await WishlistController.instance.fetchWishlist();
      }
    } catch (e) {
      userNotifier.value = null;
    } finally {
      isInitializedNotifier.value = true;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    final authService = AuthService();
    await authService.logout();
    CartController.instance.clear();
    WishlistController.instance.fetchWishlist();
    userNotifier.value = null;
    notifyListeners();
  }
}
