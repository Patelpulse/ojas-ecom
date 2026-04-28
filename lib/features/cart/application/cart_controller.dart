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
    _initCart();
  }

  Future<void> _initCart() async {
    await _loadLocalCart();
    final token = await _getToken();
    if (token != null) {
      await loadCart();
    }
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
            
        int quantity = item['quantity'] ?? 1;
        int moq = product['moq'] ?? 1;
        double moqDiscount = (product['moqDiscount'] ?? 0).toDouble();

        if (quantity >= moq && moqDiscount > 0) {
          price = price - (price * (moqDiscount / 100));
        }
        
        price = price.roundToDouble();
            
        total += price * quantity;
      }
    }
    return total;
  }

  double get savings {
    double saved = 0;
    for (var item in _items) {
      final product = item['product'];
      if (product != null && product is Map && product['price'] != null) {
        double originalPrice = (product['price']).toDouble();
        double currentPrice = (product['discountPrice'] != null && product['discountPrice'] > 0 
            ? product['discountPrice'] 
            : originalPrice).toDouble();

        int quantity = item['quantity'] ?? 1;
        int moq = product['moq'] ?? 1;
        double moqDiscount = (product['moqDiscount'] ?? 0).toDouble();

        if (quantity >= moq && moqDiscount > 0) {
          currentPrice = currentPrice - (currentPrice * (moqDiscount / 100));
        }
        
        currentPrice = currentPrice.roundToDouble();

        double diff = originalPrice - currentPrice;
        if (diff > 0) {
          saved += diff * quantity;
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

  Future<bool> addToCart(String productId, {int quantity = 1, int? moq}) async {
    final token = await _getToken();
    if (token == null) return false;
    
    int qtyToAdd = quantity;
    if (moq != null && moq > 1 && quantity == 1) {
      bool exists = _items.any((item) {
        final p = item['product'];
        return p != null && (p['_id'] == productId || p['id'] == productId);
      });
      if (!exists) {
        qtyToAdd = moq;
      }
    }

    final success = await _cartService.addToCart(productId, quantity: qtyToAdd);
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
