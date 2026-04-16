import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ojas_user/core/services/api_service.dart';

class CartService {
  String get endpoint => ApiService.userBaseUrl;

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_auth_token');
  }

  Future<bool> addToCart(String productId, {int quantity = 1}) async {
    try {
      final token = await _getToken();
      if (token == null) return false;

      final response = await http.post(
        Uri.parse('$endpoint/cart/add'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'productId': productId,
          'quantity': quantity,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Add to cart error: $e');
      return false;
    }
  }

  Future<List<dynamic>> getCart() async {
    try {
      final token = await _getToken();
      if (token == null) return [];

      final response = await http.get(
        Uri.parse('$endpoint/cart'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'] ?? [];
      }
      return [];
    } catch (e) {
      debugPrint('Get cart error: $e');
      return [];
    }
  }

  Future<bool> removeFromCart(String productId) async {
    try {
      final token = await _getToken();
      if (token == null) return false;

      final response = await http.post(
        Uri.parse('$endpoint/cart/remove'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'productId': productId}),
      );

      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Remove from cart error: $e');
      return false;
    }
  }

  Future<bool> checkout(Map<String, dynamic> shippingAddress) async {
    try {
      final token = await _getToken();
      if (token == null) return false;

      final response = await http.post(
        Uri.parse('${ApiService.baseUrl}/order/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'shippingAddress': shippingAddress,
        }),
      );

      if (response.statusCode == 201) {
         return true;
      }
      return false;
    } catch (e) {
      debugPrint('Checkout error: $e');
      return false;
    }
  }
}
