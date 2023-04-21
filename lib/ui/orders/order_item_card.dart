import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/order_item.dart';

class OrderItemCard extends StatelessWidget {
  final OrderItem order;

  const OrderItemCard(this.order, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        title: Text(
          'Tổng tiền: ${order.amount} VNĐ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ngày đặt hàng: ${DateFormat('dd/MM/yyyy hh:mm').format(order.dateTime)}',
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              order.isDelivery ? 'Đã giao hàng' : 'Chưa giao hàng',
              style: TextStyle(
                color: order.isDelivery ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
