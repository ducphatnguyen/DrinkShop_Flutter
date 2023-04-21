import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_manager.dart';
import 'order_item_card.dart';

import 'order_detail_screen.dart';
import '../shared/flexible_space_widget.dart';

class UserOrdersScreen extends StatelessWidget {
  static const routeName = '/user-orders';

  const UserOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersManager = Provider.of<OrdersManager>(context);
    ordersManager.fetchUserOrders(); // lấy danh sách hóa đơn từ Firebase

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng của bạn'),
        flexibleSpace: const CustomFlexibleSpaceWidget(),
      ),

      body: Consumer<OrdersManager>(
        builder: (ctx, ordersManager, child) {
          final orders = ordersManager.items; // danh sách hóa đơn
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (ctx, i) => 
            Row(
              children: <Widget>[
                Expanded(
                  child: OrderItemCard(orders[i]),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_red_eye, color: Colors.amber),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrderDetailScreen(orders[i]),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
    
  }
}
