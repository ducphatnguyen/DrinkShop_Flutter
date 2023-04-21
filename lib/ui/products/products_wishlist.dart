import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_list_tile.dart';
import 'products_manager.dart';
import '../shared/flexible_space_widget.dart';

class ProductsWishlist extends StatefulWidget {
  const ProductsWishlist({Key? key}) : super(key: key);
  static const routeName = '/wishlist';

  @override
  State<ProductsWishlist> createState() => _ProductsWishlistState();
}

class _ProductsWishlistState extends State<ProductsWishlist> {
  @override
  Widget build(BuildContext context) {
    final productsManager = Provider.of<ProductsManager>(context);
    final favoriteItems = productsManager.favoriteItems;
    return Scaffold(
      appBar: AppBar(

        title: const Text('Sản phẩm yêu thích'),

        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              //  Navigator.of(context).pushReplacementNamed(ProductsWishlist.routeName); 
              setState(() {});
            },
          ),
        ],
        flexibleSpace: const CustomFlexibleSpaceWidget(),
      ),

      body: favoriteItems.isEmpty
          ? const Center(
              child: Text('Không có sản phẩm yêu thích'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: favoriteItems.length,
              itemBuilder: (ctx, i) => ProductListTile(favoriteItems[i]),
            ),
    );
  }
}