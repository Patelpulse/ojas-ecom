import 'package:ojas_user/core/controllers/home_controller.dart';

class ProductModel {
  final String id;
  final String name;
  final double price;
  final double? oldPrice;
  final String imageUrl;
  final int discount;
  final bool isFlashDeal;
  final int? available;
  final int? sold;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.oldPrice,
    required this.imageUrl,
    this.discount = 0,
    this.isFlashDeal = false,
    this.available,
    this.sold,
  });

  factory ProductModel.fromMap(Map<String, dynamic> p) {
    double price = (p['discountPrice'] != null && p['discountPrice'] > 0 
        ? p['discountPrice'] 
        : (p['price'] ?? 0)).toDouble();
    double oldPrice = (p['price'] ?? 0).toDouble();
    int disc = oldPrice > 0 && oldPrice > price ? (((oldPrice - price) / oldPrice) * 100).toInt() : 0;

    return ProductModel(
      id: p['_id'] ?? '',
      name: p['name'] ?? 'Product',
      price: price,
      oldPrice: oldPrice > price ? oldPrice : null,
      imageUrl: p['image'] ?? 'https://via.placeholder.com/500',
      discount: disc,
      isFlashDeal: disc > 20,
      available: p['stock'] ?? 10,
      sold: 5, // Mocked sold count
    );
  }

  static List<ProductModel> get dummyProducts {
    return HomeController.instance.products.map((p) => ProductModel.fromMap(p)).toList();
  }

  static List<ProductModel> getFlashDeals() {
    final all = dummyProducts;
    return all.where((p) => p.isFlashDeal).toList();
  }

  static List<ProductModel> getDailyDeals() {
    final all = dummyProducts;
    if (all.isEmpty) return [];
    // Just return first two for daily deals
    return all.take(2).toList();
  }
}
