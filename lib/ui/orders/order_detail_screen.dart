import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/order_item.dart';
import '../shared/flexible_space_widget.dart';
import 'order_manager.dart';
import '../auth/auth_manager.dart';

class OrderDetailScreen extends StatelessWidget {
  static const routeName = '/order-detail';
  final OrderItem order;

  const OrderDetailScreen(
    this.order, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.watch<AuthManager>().isAdmin;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
        flexibleSpace: const CustomFlexibleSpaceWidget(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Mã đơn hàng: ${order.id}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Tổng tiền: ${order.amount} VNĐ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Ngày đặt hàng: ${DateFormat('dd/MM/yyyy hh:mm').format(order.dateTime)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'SĐT người đặt: ${order.phone}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Danh sách sản phẩm đã đặt:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                final product = order.products[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(product.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${product.quantity} x ${product.price} VNĐ',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${product.quantity * product.price} VNĐ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                  ],
                );
              },
              itemCount: order.products.length,
            ),
            if (order.isDelivery == false && isAdmin == true)
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final orderManager = context.read<OrdersManager>();
                    await orderManager.updateDeliveryStatus(order.id as String);

                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Row(
                            children: const [
                              Icon(Icons.check, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                  'Đã duyệt đơn hàng thành công',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 3),
                        ),
                      );
                  },
                  child: const Text('Xác nhận đã giao hàng'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
