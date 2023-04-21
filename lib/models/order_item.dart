import 'cart_item.dart';

class OrderItem {
  final String? id;
  final double amount;
  final String phone;
  final List<CartItem> products;
  final DateTime dateTime;
  bool isDelivery;

  int get productCount {
    return products.length;
  }

  OrderItem({
    this.id,
    required this.amount,
    required this.phone,
    required this.products,
    DateTime? dateTime,
    this.isDelivery = false,
  }) : dateTime = dateTime ?? DateTime.now();

  OrderItem copyWith({
    String? id,
    double? amount,
    String? phone,
    List<CartItem>? products,
    DateTime? dateTime,
    bool? isDelivery,
  }) {
    return OrderItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      phone: phone ?? this.phone,
      products: products ?? this.products,
      dateTime: dateTime ?? this.dateTime,
      isDelivery: isDelivery ?? this.isDelivery,
    );
  }

  //FB
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productsJson =
        products.map((product) => product.toJson()).toList();

    return {
      'id': id,
      'amount': amount,
      'phone': phone,
      'products': productsJson,
      'dateTime': dateTime.toIso8601String(),
      'isDelivery': isDelivery,
    };
  }

  static OrderItem fromJson(Map<String, dynamic> json) {
    List<dynamic> productsJson = json['products'];
    List<CartItem> products = productsJson
        .map((productJson) => CartItem.fromJson(productJson))
        .toList();

    return OrderItem(
      id: json['id'],
      amount: json['amount'],
      phone: json['phone'],
      products: products,
      dateTime: DateTime.parse(json['dateTime']),
      isDelivery: json['isDelivery'],
    );
  }
}
