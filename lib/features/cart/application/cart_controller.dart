import 'package:flutter/material.dart';
import 'cart_service.dart';

class CartController extends ChangeNotifier {
  static final CartController _instance = CartController._internal();
  static CartController get instance => _instance;

  CartController._internal();

  final CartService _cartService = CartService();
  List<dynamic> _items = [];
  bool _isLoading = false;

  List<dynamic> get items => _items;
  bool get isLoading => _isLoading;
  int get itemCount => _items.length;

  Future<void> loadCart() async {
    _isLoading = true;
    notifyListeners();

    _items = await _cartService.getCart();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addToCart(String productId, {int quantity = 1}) async {
    final success = await _cartService.addToCart(productId, quantity: quantity);
    if (success) {
      await loadCart();
    }
    return success;
  }
}
