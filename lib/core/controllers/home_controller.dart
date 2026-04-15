import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ojas_user/core/services/api_service.dart';
import 'package:ojas_user/core/services/socket_service.dart';

class HomeController with ChangeNotifier {
  static final HomeController instance = HomeController._internal();
  HomeController._internal();

  List<dynamic> _categories = [];
  List<dynamic> _products = [];
  bool _isLoading = false;

  List<dynamic> get categories => _categories;
  List<dynamic> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    await fetchData();
    
    // Listen for category updates
    SocketService.instance.on('category', (data) {
      debugPrint('Category socket update: ${data['action']}');
      fetchCategories(); // Simple strategy: re-fetch from API to ensure consistency
    });

    // Listen for product updates
    SocketService.instance.on('product', (data) {
      debugPrint('Product socket update: ${data['action']}');
      fetchProducts();
    });
  }

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();
    await Future.wait([fetchCategories(), fetchProducts()]);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('${ApiService.baseUrl}/home/categories'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _categories = data['data'] ?? [];
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    }
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('${ApiService.baseUrl}/home/products'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _products = data['data'] ?? [];
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching products: $e');
    }
  }
}
