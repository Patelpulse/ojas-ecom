class OrderModel {
  final String id;
  final String orderId;
  final String status;
  final double totalAmount;
  final String paymentStatus;
  final List<OrderItem> items;
  final ShippingAddress shippingAddress;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.orderId,
    required this.status,
    required this.totalAmount,
    required this.paymentStatus,
    required this.items,
    required this.shippingAddress,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'] ?? '',
      orderId: json['orderId'] ?? '',
      status: json['status'] ?? 'Pending',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      paymentStatus: json['paymentStatus'] ?? 'Unpaid',
      items: (json['items'] as List?)?.map((i) => OrderItem.fromJson(i)).toList() ?? [],
      shippingAddress: ShippingAddress.fromJson(json['shippingAddress'] ?? {}),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'orderId': orderId,
      'status': status,
      'totalAmount': totalAmount,
      'paymentStatus': paymentStatus,
      'items': items.map((i) => i.toJson()).toList(),
      'shippingAddress': shippingAddress.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class OrderItem {
  final String productId;
  final String name;
  final int quantity;
  final double price;
  final String image;

  OrderItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product'] ?? '',
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
      'image': image,
    };
  }
}

class ShippingAddress {
  final String street;
  final String city;
  final String state;
  final String zipCode;

  ShippingAddress({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      street: json['street'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipCode: json['zipCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
    };
  }

  @override
  String toString() {
    return '$street, $city, $state, $zipCode';
  }
}
