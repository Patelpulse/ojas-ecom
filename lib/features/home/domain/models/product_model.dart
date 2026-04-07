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

  static List<ProductModel> get dummyProducts => [
    ProductModel(
      id: '1',
      name: 'Premium Wireless Headphones',
      price: 199.99,
      oldPrice: 299.99,
      discount: 33,
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
      isFlashDeal: true,
    ),
    ProductModel(
      id: '2',
      name: 'Smart Watch Series 7',
      price: 349.99,
      oldPrice: 399.99,
      discount: 12,
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
      isFlashDeal: true,
    ),
    ProductModel(
      id: '3',
      name: 'Designer Casual Shoes',
      price: 89.99,
      oldPrice: 120.00,
      discount: 25,
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500',
    ),
    ProductModel(
      id: '4',
      name: 'Ultra HD 4K Smart TV',
      price: 599.99,
      oldPrice: 799.99,
      discount: 25,
      imageUrl: 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=500',
      isFlashDeal: true,
    ),
    ProductModel(
      id: '5',
      name: 'Organic Green Tea (Pack of 3)',
      price: 24.99,
      imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500',
    ),
    ProductModel(
      id: '6',
      name: 'Professional DSLR Camera',
      price: 1299.99,
      oldPrice: 1499.99,
      discount: 13,
      imageUrl: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=500',
    ),
  ];

  static List<ProductModel> getFlashDeals() {
    return dummyProducts.where((product) => product.isFlashDeal).toList();
  }

  static List<ProductModel> getDailyDeals() {
    return [
      ProductModel(
        id: 'd1',
        name: 'The Chandralok - Bar | Kitchen | Banquet',
        price: 100.00,
        oldPrice: 167.00,
        discount: 1,
        imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800',
        available: 10,
        sold: 29,
      ),
      ProductModel(
        id: 'd2',
        name: 'Aerofit Spin Bike AF-780 (Yellow/Black) - 12 kg High Inertia Spin Wheel',
        price: 42999.00,
        oldPrice: 71808.33,
        discount: 25,
        imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800',
        available: 56,
        sold: 9,
      ),
    ];
  }
}
