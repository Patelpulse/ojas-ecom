import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ojas_user/core/controllers/home_controller.dart';
import 'cart_service.dart';

class CartController extends ChangeNotifier {
  static final CartController _instance = CartController._internal();
  static CartController get instance => _instance;

  CartController._internal() {
    _loadLocalCart();
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_auth_token');
  }

  Future<void> _loadLocalCart() async {
    final token = await _getToken();
    if (token == null) {
      _items = [];
      notifyListeners();
      return;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedCart = prefs.getString('local_cart_data');
      if (savedCart != null) {
        _items = json.decode(savedCart);
        notifyListeners();
      }
    } catch (e) {
      _items = [];
    }
  }

  Future<void> _saveLocalCart(List<dynamic> items) async {
    final token = await _getToken();
    if (token == null) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('local_cart_data', json.encode(items));
    } catch (e) {
      debugPrint('Failed to save local cart: $e');
    }
  }

  final CartService _cartService = CartService();
  List<dynamic> _items = [];
  bool _isLoading = false;

  List<dynamic> get items => _items;
  bool get isLoading => _isLoading;
  int get itemCount => _items.length;

  double get subtotal {
    double total = 0;
    for (var item in _items) {
      final product = item['product'];
      if (product != null && product is Map) {
        double price = (product['discountPrice'] != null && product['discountPrice'] > 0 
            ? product['discountPrice'] 
            : (product['price'] ?? 0)).toDouble();
        total += price * (item['quantity'] ?? 1);
      }
    }
    return total;
  }

  double get savings {
    double saved = 0;
    for (var item in _items) {
      final product = item['product'];
      if (product != null && product is Map && 
          product['discountPrice'] != null && 
          product['discountPrice'] > 0 && 
          product['price'] != null) {
        double diff = (product['price'] - product['discountPrice']).toDouble();
        if (diff > 0) {
          saved += diff * (item['quantity'] ?? 1);
        }
      }
    }
    return saved;
  }

  double get tax => subtotal * 0.18; // 18% tax example
  double get totalAmount => subtotal + tax;

  Future<void> loadCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      final apiItems = await _cartService.getCart();
      // Only override if we received a valid list response (even if empty, it means true empty)
      _items = apiItems;
      _saveLocalCart(_items);
    } catch(e) {
      // Fallback to local items if API utterly fails or is completely unauthorized
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addToCart(String productId, {int quantity = 1}) async {
    final token = await _getToken();
    if (token == null) return false;
    
    final success = await _cartService.addToCart(productId, quantity: quantity);
    if (success) {
      await loadCart();
      return true;
    }
    return false;
  }

  Future<bool> removeFromCart(String productId) async {
    final token = await _getToken();
    if (token == null) return false;

    final success = await _cartService.removeFromCart(productId);
    if (success) {
      await loadCart();
      return true;
    }
    return false;
  }

  void clear() {
    _items = [];
    _saveLocalCart([]);
    notifyListeners();
  }

  Future<bool> checkout({required Map<String, dynamic> shippingAddress}) async {
    _isLoading = true;
    notifyListeners();

    final success = await _cartService.checkout(shippingAddress);
    
    if (success) {
      _items = []; // Optimistically clear cart
      _saveLocalCart(_items);
      await loadCart();
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }
}
