import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../models/product.dart';
import 'product_list_tile.dart';
import 'products_manager.dart';

class ProductsList extends StatelessWidget {
  final bool showFavorites;

  ProductsList(this.showFavorites, {Key? key}) : super(key: key);

  //Slider
  final List<String> _images = [
    'https://www.rawpressery.com/assets/imgs/product_images/base/value-packs/d/mango_250ml_p30_1ann.jpg',
    'https://www.sapakitchen.vn/uploads/files/2018/12/24/nuoc-ep-ca-rot-cung-mang-nguon-dinh-duong-khong-kem.jpg',
    'https://www.rawpressery.com/assets/imgs/product_images/base/juices/d/guava_250ml_p1_1nn.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    
    // final productsManager = Provider.of<ProductsManager>(context);
    // final products = productsManager.items;

    // Đọc ra List<Product> sẽ được hiển thị từ ProductsManager (render truy cập 1 phần đối tượng)
    final products = context.select<ProductsManager, List<Product>>(
        (productsManager) => showFavorites
            ? productsManager.favoriteItems
            : productsManager.items);

    return SingleChildScrollView(
      child: Column(
        children: [
          // Top 3 sản phẩm yêu thích
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              'TOP 3 SẢN PHẨM YÊU THÍCH',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange, // thêm màu cho chữ
              ),
            ),
          ),

          // Slider body
          CarouselSlider(
            items: _images.map((imageUrl) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.1),
                      BlendMode.darken,
                    ),
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              enlargeCenterPage: true,
              aspectRatio: 20 / 9,
              viewportFraction: 0.8,
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              'MENU THỨC UỐNG',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange, // thêm màu cho chữ
              ),
            ),
          ),

          ListView.builder(
            padding: const EdgeInsets.all(10.0),
            //giảm kích thước ListView.builder cho nd hiển thị bên trong
            shrinkWrap: true,
            //tắt tính năng cuộn tự động của listview để cuộn cho cả slider
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (ctx, i) => ProductListTile(products[i]),
          ),
        ],
      ),
    );
  }
}
