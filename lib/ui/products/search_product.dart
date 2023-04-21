import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_list_tile.dart';
import 'products_manager.dart';
import '../shared/flexible_space_widget.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  String _searchQuery = '';
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final productsManager = Provider.of<ProductsManager>(context);

    final filteredProducts = productsManager.searchProducts(_searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          focusNode: _searchFocusNode,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm sản phẩm',
            fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: const Icon(Icons.clear),
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 16.0,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
        flexibleSpace: const CustomFlexibleSpaceWidget(),
      ),
      body: filteredProducts.isNotEmpty
          ? ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (ctx, i) => ProductListTile(filteredProducts[i]),
            )
          : const Center(
              child: Text('Không tìm thấy sản phẩm phù hợp'),
            ),
    );
  }
}