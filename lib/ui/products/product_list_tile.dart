// Các sản phẩm được lấy
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../products/product_detail_screen.dart';
import 'products_manager.dart';

import '../cart/cart_manager.dart';
import '../../models/product.dart';

class ProductListTile extends StatefulWidget {
  final Product product;

  const ProductListTile(
    this.product, {
    Key? key,
  }) : super(key: key);

  @override
  State<ProductListTile> createState() => _ProductListTileState();
}

class _ProductListTileState extends State<ProductListTile> {
  int quantity = 1; // Số lượng sản phẩm mặc định là 1
  @override
  void initState() {
    super.initState();
    quantity = 1;
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(widget.product),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 125,
                    width: 120,
                    child: Image.network(
                      widget.product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.product.discount! > 0
                            ? '${widget.product.price} VNĐ'
                            : '${(widget.product.price * (1 - (widget.product.discount ?? 0) / 100))} VNĐ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          decoration: widget.product.discount! > 0
                              ? TextDecoration.lineThrough
                              : null,
                          decorationColor: Colors.grey,
                        ),
                      ),
                      if (widget.product.discount! > 0)
                        Text(
                          '${(widget.product.price * (1 - (widget.product.discount ?? 0) / 100))} VNĐ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable:
                                widget.product.isFavoriteListenable,
                            builder: (ctx, isFavorite, child) {
                              return IconButton(
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                ),
                                color: Theme.of(context).colorScheme.secondary,
                                onPressed: () {
                                  ctx
                                      .read<ProductsManager>()
                                      .toggleFavoriteStatus(widget.product);
                                },
                              );
                            },
                          ),
                          if (widget.product.isAvailable == true)
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (quantity > 1) {
                                          quantity = quantity - 1;
                                        }
                                      });
                                    },
                                  ),
                                  Text(quantity.toString()),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        quantity = quantity + 1;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.shopping_cart),
                                    onPressed: () {
                                      //Thêm sản phẩm vào giỏ hàng (lưu thuộc tính product và số lượng mới)
                                      cart.addItem(widget.product, quantity);

                                      //Thông điệp hiển thị sau khi thêm vào giỏ hàng
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(
                                          SnackBar(
                                            content: Row(
                                              children: const [
                                                Icon(Icons.check,
                                                    color: Colors.white),
                                                SizedBox(width: 8),
                                                Text('Thêm vào giỏ hàng thành công',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ],
                                            ),
                                            backgroundColor: Colors.green,
                                            duration:
                                                const Duration(seconds: 3),
                                            action: SnackBarAction(
                                              label: 'UNDO',
                                              onPressed: () {
                                                cart.removeSingleItem(
                                                    widget.product.id!);
                                              },
                                            ),
                                          ),
                                        );
                                    },
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (widget.product.discount! > 0)
            //Đặt vị trí con trong stack
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Giảm giá: ${widget.product.discount?.toString() ?? ""}%',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (widget.product.isAvailable == false)
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'Hết hàng',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
