// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_manager.dart';
import 'cart_item_card.dart';

import '../orders/order_manager.dart';
import '../shared/flexible_space_widget.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        flexibleSpace: const CustomFlexibleSpaceWidget(),
      ),
      body: Column(
        children: <Widget>[
          buildCartSummary(cart, context),
          const SizedBox(height: 10),
          Expanded(
            child: buildCartDetails(cart),
          )
        ],
      ),
    );
  }

  Widget buildCartDetails(CartManager cart) {
    return ListView(
      children: cart.productEntries
          .map(
            (entry) => CartItemCard(
              productId: entry.key,
              cardItem: entry.value,
            ),
          )
          .toList(),
    );
  }

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    if (cart.productEntries.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://bizweb.dktcdn.net/100/320/202/themes/714916/assets/empty-cart.png?1650292912948',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 20),
          Builder(
            builder: (ctx) => ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pushNamed('/');
              },
              child: const Text('Mua nước ngay'),
            ),
          ),
        ],
      );
    } else {
      return Card(
        margin: const EdgeInsets.all(15),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Tổng tiền',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Chip(
                label: Text(
                  '${cart.totalAmount.toStringAsFixed(2)} VNĐ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.green,
              ),
              const SizedBox(width: 10),
              TextButton(
                //Gọi phương thức tính toán totalAmount
                onPressed: cart.totalAmount <= 0
                    ? null
                    : () async {
                        final phoneController = TextEditingController();

                        await showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text(
                              'Nhập SĐT của bạn để đặt hàng (*)',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'Chúng tôi sẽ liên hệ qua SĐT này',
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Huỷ'),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () async {
                                  bool isPhoneNumberValid = false;
                                  if (phoneController.text.isNotEmpty &&
                                      RegExp(r'^\d{10}$')
                                          .hasMatch(phoneController.text)) {
                                    isPhoneNumberValid = true;
                                  }
                                  if (isPhoneNumberValid) {
                                    final orderManager =
                                        context.read<OrdersManager>();
                                    await orderManager.addOrder(
                                      cart.products,
                                      cart.totalAmount,
                                      phoneController.text,
                                    );
                                    cart.clear();

                                    Navigator.of(ctx).pop();

                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                        SnackBar(
                                          content: Row(
                                            children: const [
                                              Icon(Icons.check,
                                                  color: Colors.white),
                                              SizedBox(width: 8),
                                              Text(
                                                  'Đặt hàng thành công, xem chi tiết tại đơn hàng',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                          backgroundColor: Colors.green,
                                          duration: const Duration(seconds: 3),
                                        ),
                                      );
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },

                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                //Text của button
                child: const Text(
                  'ĐẶT HÀNG',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
