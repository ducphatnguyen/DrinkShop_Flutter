import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'products_list.dart';
import '../products/search_product.dart';
import '../products/products_manager.dart';

import '../cart/cart_screen.dart';
import '../cart/cart_manager.dart';

import '../auth/auth_manager.dart';

import 'top_right_badge.dart';
import '../shared/flexible_space_widget.dart';
import '../shared/bottom_navigation.dart';
import '../shared/app_drawer.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {

  const ProductsOverviewScreen({super.key});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;

  @override
  void initState() {
    super.initState();
    //Nạp sản phẩm
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.watch<AuthManager>().isAdmin;
    return Scaffold(
      // 1. AppBar
      appBar: AppBar(
        title: GestureDetector(

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchProduct(),
              ),
            );
          },
          
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Tìm kiếm sản phẩm',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          
        ),
        actions: [
          // buildProductFilterMenu(),
          buildShoppingCartIcon(),
        ],
        flexibleSpace: const CustomFlexibleSpaceWidget(),
      ),

      // 2. drawer
      drawer: isAdmin ? const AppDrawer() : null,
      // drawer: const AppDrawer(),
      
      // 3. body
      body: FutureBuilder(
        future: _fetchProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                //Thêm child
                Expanded(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _showOnlyFavorites,
                    builder: (context, onlyFavorites, child) {
                      return ProductsList(onlyFavorites);
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  //Icon giỏ hàng (cập nhật sự thay đổi widget cha provide - một phần widget)
  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (ctx, cartManager, child) {
        return TopRightBadge(
          data: cartManager.productCount,
          child: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.of(ctx).pushNamed(CartScreen.routeName);
            },
          ),
        );
      },
    );
  }

}
