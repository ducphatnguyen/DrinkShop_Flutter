//Test
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_manager.dart';
import 'order_item_card.dart';
import 'order_detail_screen.dart';

import '../shared/app_drawer.dart';
import '../shared/flexible_space_widget.dart';

class AllOrdersScreen extends StatelessWidget {
  static const routeName = '/all-orders';

  const AllOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ordersManager = Provider.of<OrdersManager>(context);
    ordersManager.fetchAllOrders(); // lấy danh sách hóa đơn từ Firebase

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lí hóa đơn khách hàng'),
        flexibleSpace: const CustomFlexibleSpaceWidget(),
      ),

      // 2. drawer
      drawer: const AppDrawer(),

      body: Consumer<OrdersManager>(
        builder: (ctx, ordersManager, child) {
          final orders = ordersManager.items; // danh sách hóa đơn
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (ctx, i) => Row(
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
