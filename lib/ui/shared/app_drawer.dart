import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/auth_manager.dart';
import '../orders/all_orders_screen.dart';
import '../products/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.watch<AuthManager>().isAdmin;
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const NetworkImage(
                  'https://topbrands.vn/wp-content/uploads/2021/08/Nuoc-ep-trai-cay-dong-chai.jpg',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('QUẢN TRỊ VIÊN'),
            ),
          ),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop, color: Colors.red),
            title: const Text('Cửa Hàng'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),

          const Divider(),
          isAdmin == true
        ? ListTile(
            leading: const Icon(Icons.local_drink, color: Colors.red),
            title: const Text('Quản Lí Nước Uống'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          )
        : const SizedBox(),
        //  ListTile(
        //     leading: const Icon(Icons.edit, color: Colors.red),
        //     title: const Text('Quản Lí Nước Uống'),
        //     onTap: () {
        //       Navigator.of(context)
        //           .pushReplacementNamed(UserProductsScreen.routeName);
        //     },
        //   ), 

         const Divider(),
          isAdmin == true
        ? ListTile(
            leading: const Icon(Icons.assignment, color: Colors.red),
            title: const Text('Quản lí hóa đơn'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AllOrdersScreen.routeName);
            },
          )
        : const SizedBox(), 

          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text('Đăng Xuất'),
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..pushReplacementNamed('/');
              context.read<AuthManager>().logout();
            },
          ),

        ],

      ),
    );
  }
}
