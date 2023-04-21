import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/order_item.dart';
import '../models/auth_token.dart';

//Lấy user_id
import 'firebase_service.dart';

class OrdersService extends FirebaseService {
  OrdersService([AuthToken? authToken]) : super(authToken);

  // Future<OrderItem?> addOrder(OrderItem order) async {
  //   try {
  //     final url = Uri.parse(
  //         // '$databaseUrl/orders.json?auth=$token'
  //         // '$databaseUrl/userOrders/$userId/${order.id}.json?auth=$token'
  //         '$databaseUrl/userOrders/$userId/orders.json?auth=$token');
  //     final response = await http.post(
  //       url,
  //       body: json.encode(order.toJson()
  //           // ..addAll({
  //           //   // 'creatorId' : userId,
  //           // }),
  //           ),
  //     );

  //     print(url);
  //     // print(token);
  //     if (response.statusCode != 200) {
  //       throw Exception(json.decode(response.body)['error']);
  //     }

  //     return order.copyWith(
  //       id: json.decode(response.body)['name'],
  //     );
  //   } catch (error) {
  //     print(error);
  //     return null;
  //   }
  // }

  //User orders
  // Future<List<OrderItem>> fetchUserOrders([bool filterByUser = false]) async {
  //   final List<OrderItem> orders = [];

  //   try {
  //     // final filters =
  //     //     filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

  //     // final ordersUrl = Uri.parse(
  //     //     '$databaseUrl/userOrders/$userId/orders.json?auth=$token&$filters');

  //     final ordersUrl = Uri.parse(
  //         '$databaseUrl/userOrders/$userId/orders.json?auth=$token');
          
  //     final response = await http.get(ordersUrl);
  //     final ordersMap = json.decode(response.body) as Map<String, dynamic>;

  //     if (response.statusCode != 200) {
  //       throw Exception(json.decode(response.body)['error']);
  //     }

  //     ordersMap.forEach((orderId, order) {
  //       orders.add(OrderItem.fromJson({
  //         'id': orderId,
  //         ...order,
  //       }));
  //     });
  //     return orders;
  //   } catch (error) {
  //     print(error);
  //     return orders;
  //   }
  // }

  //Test
  // Future<List<OrderItem>> fetchAllOrders() async {
  //   final List<OrderItem> orders = [];
  //   try {
  //     final ordersUrl = Uri.parse('$databaseUrl/userOrders.json?auth=$token');
  //     final response = await http.get(ordersUrl);
  //     final ordersMap = json.decode(response.body) as Map<String, dynamic>;

  //     if (response.statusCode != 200) {
  //       throw Exception(json.decode(response.body)['error']);
  //     }

  //     ordersMap.forEach((userId, userOrders) {
  //       if (userOrders['orders'] != null) {
  //         userOrders['orders'].forEach((orderId, order) {
  //           if (order != null) {
  //             orders.add(OrderItem.fromJson({
  //               'id': orderId,
  //               ...order,
  //             }));
  //           }
  //         });
  //       }
  //     });

  //     return orders;
  //   } catch (error) {
  //     print(error);
  //     return orders;
  //   }
  // }

  Future<OrderItem?> addOrder(OrderItem order) async {
    try {
      final url = Uri.parse('$databaseUrl/orders.json?auth=$token');

      final response = await http.post(
        url,
        body: json.encode(
          order.toJson()
            ..addAll({
              'userId': userId,
            }),
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }

      return order.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<OrderItem>> fetchUserOrders([bool filterByUser = true]) async {

    final List<OrderItem> orders = [];

    try {
      final filters =
          filterByUser ? 'orderBy="userId"&equalTo="$userId"' : '';
      final ordersUrl =
          Uri.parse('$databaseUrl/orders.json?auth=$token&$filters');
      final response = await http.get(ordersUrl);
      final ordersMap = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(ordersMap['error']);
        return orders;
      }

      ordersMap.forEach((productId, product) {

        orders.add(
          OrderItem.fromJson({
            'id': productId,
            ...product,
          })
        );
      });
      return orders;
    } catch (error) {
      print(error);
      return orders;
    }
  }

    Future<List<OrderItem>> fetchAllOrders([bool filterByUser = false]) async {
    final List<OrderItem> orders = [];

    try {
      final filters =
          filterByUser ? 'orderBy="userId"&equalTo="$userId"' : '';
      final ordersUrl =
          Uri.parse('$databaseUrl/orders.json?auth=$token&$filters');
      final response = await http.get(ordersUrl);

      final ordersMap = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(ordersMap['error']);
        return orders;
      }

      ordersMap.forEach((productId, product) {

        orders.add(
          OrderItem.fromJson({
            'id': productId,
            ...product,
          })
        );
      });
      return orders;
    } catch (error) {
      print(error);
      return orders;
    }
  }

  Future<bool> updateDeliveryStatus(String orderId) async {
  try {
    final url = Uri.parse('$databaseUrl/orders/$orderId.json?auth=$token');
    final response = await http.patch(
      url,
      body: json.encode({'isDelivery': true}),
    );

    if (response.statusCode != 200) {
      throw Exception(json.decode(response.body)['error']);
    }

    return true;
  } catch (error) {
    print(error);
    return false;
  }
}


}
