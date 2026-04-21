import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ojas_user/core/services/api_service.dart';
import 'package:ojas_user/core/services/socket_service.dart';

import 'package:ojas_user/features/home/data/models/banner_model.dart';

class HomeController with ChangeNotifier {
  static final HomeController instance = HomeController._internal();
  HomeController._internal();

  List<dynamic> _categories = [];
  List<dynamic> _products = [];
  List<BannerModel> _banners = [];
  bool _isLoading = false;

  List<dynamic> get categories => _categories;
  /// All in-stock products (stock > 0)
  List<dynamic> get products => _products.where((p) => (p['stock'] ?? 0) > 0).toList();
  List<BannerModel> get banners => _banners;
  bool get isLoading => _isLoading;

  List<dynamic> get homeProducts => products.where((p) => (p['showOnPages'] as List?)?.contains('Home') ?? false).toList();
  List<dynamic> get featureProducts => products.where((p) => (p['showOnPages'] as List?)?.contains('Features') ?? false).toList();
  List<dynamic> get dealProducts => products.where((p) => (p['showOnPages'] as List?)?.contains('Deals') ?? false).toList();
  List<dynamic> get shopProducts => products.where((p) => (p['showOnPages'] as List?)?.contains('Shop') ?? true).toList();

  List<BannerModel> get mainBanners => _banners.where((b) => b.type == 'main' || b.type == 'main_slider_1' || b.type == 'main_slider_2').toList();
  BannerModel get sideTopBanner => _banners.firstWhere((b) => b.type == 'side_top', orElse: () => _defaultSideTop);
  BannerModel get sideBottomBanner => _banners.firstWhere((b) => b.type == 'side_bottom', orElse: () => _defaultSideBottom);
  BannerModel get offerBanner => _banners.firstWhere((b) => b.type == 'offer', orElse: () => _defaultOfferBanner);
  BannerModel get trendingBanner => _banners.firstWhere((b) => b.type == 'trending', orElse: () => _defaultTrendingBanner);
  List<BannerModel> get promoBanners => _banners.where((b) => b.type == 'promo').toList();

  final _defaultSideTop = BannerModel(
    id: 'default_top',
    title: 'COLORFUL PILLOWS',
    subtitle: 'Starts at ₹299',
    imageUrl: 'assets/images/colorful_pillows_promo.png',
    link: '/',
    tag: 'Trending',
    type: 'side_top',
  );

  final _defaultSideBottom = BannerModel(
    id: 'default_bottom',
    title: 'INTERIOR DESIGN',
    subtitle: '₹499',
    imageUrl: 'assets/images/interior_design_promo.png',
    link: '/',
    tag: 'Premium',
    type: 'side_bottom',
  );

  final _defaultOfferBanner = BannerModel(
    id: 'default_offer',
    title: 'Get 50% OFF Your First Order',
    subtitle: 'Discover amazing deals on premium products. Limited time offer for new customers only!',
    imageUrl: '', // This one uses a gradient background in the component
    link: '/',
    tag: 'LIMITED TIME',
    type: 'offer',
  );
  
  final _defaultTrendingBanner = BannerModel(
    id: 'default_trending',
    title: 'ARMCHAIR FURNITURE',
    subtitle: 'up to 50% OFF',
    imageUrl: 'https://images.unsplash.com/photo-1592078615290-033ee584e267?w=800',
    link: '/',
    tag: 'Trending',
    type: 'trending',
  );

  Future<void> init() async {
    await fetchData();
    
    // Listen for category updates
    SocketService.instance.on('category', (data) {
      debugPrint('Category socket update: ${data['action']}');
      fetchCategories();
    });

    // Listen for product updates
    SocketService.instance.on('product', (data) {
      debugPrint('Product socket update: ${data['action']}');
      fetchProducts();
    });

    // Listen for banner updates
    SocketService.instance.on('admin_data_updated', (data) {
      if (data['type'] == 'banner') {
        debugPrint('Banner socket update received');
        fetchBanners();
      }
    });
  }

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();
    await Future.wait([fetchCategories(), fetchProducts(), fetchBanners()]);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse('${ApiService.baseUrl}/home/banners'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> bannerList = data['data'] ?? [];
        _banners = bannerList.map((j) => BannerModel.fromJson(j)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching banners: $e');
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('${ApiService.baseUrl}/home/categories?type=approved&tree=true'));
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
