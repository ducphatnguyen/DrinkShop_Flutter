import 'package:flutter/foundation.dart';

import '../../models/cart_item.dart';
import '../../models/order_item.dart';
import '../../models/auth_token.dart';

import '../../services/orders_service.dart';

class OrdersManager with ChangeNotifier {
  List<OrderItem> _items = [];

  final OrdersService _ordersService;

  OrdersManager([AuthToken? authToken])
      : _ordersService = OrdersService(authToken);

  set authToken(AuthToken? authToken) {
    _ordersService.authToken = authToken;
  }

  //Test
  // Future<void> fetchAllOrders() async {
  //   _items = await _ordersService.fetchAllOrders();
  //   notifyListeners();
  // }

  //User order
  Future<void> fetchUserOrders([bool filterByUser = true]) async {
    _items = await _ordersService.fetchUserOrders(filterByUser);
    notifyListeners();
  }

  Future<void> fetchAllOrders([bool filterByUser = false]) async {
    _items = await _ordersService.fetchAllOrders(filterByUser);
    notifyListeners();
  }

  Future<void> updateDeliveryStatus(String orderId) async {
  if (await _ordersService.updateDeliveryStatus(orderId)) {
    final index = _items.indexWhere((item) => item.id == orderId);
    if (index >= 0) {
      _items[index].isDelivery = true;
      notifyListeners();
    }
  }
}


  Future<void> addOrder(
      List<CartItem> cartProducts, double total, String phone) async {
    final order = OrderItem(
      // id: 'o${DateTime.now().toIso8601String()}',
      amount: total,
      phone: phone,
      products: cartProducts,
      isDelivery: false,
      dateTime: DateTime.now(),
    );

    final newOrder = await _ordersService.addOrder(order);

    if (newOrder != null) {
      _items.insert(0, newOrder);
      notifyListeners();
    }
  }

  int get itemCount {
    return _items.length;
  }

  List<OrderItem> get items {
    return [..._items];
  }

  OrderItem? findById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }
}
