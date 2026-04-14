import 'dart:convert';
import 'dart:html' as html; // Web-only
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ojas_user/core/constants/app_constants.dart';

class CartService {
  static const String endpoint = AppConstants.apiBaseUrlUser;

  Future<String?> _getToken() async {
    if (kIsWeb) {
      return html.window.localStorage['token'];
    }
    return null;
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
      print('Add to cart error: $e');
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
      print('Get cart error: $e');
      return [];
    }
  }
}
