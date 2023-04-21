import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../products/products_manager.dart';
import '../products/edit_product_screen.dart';
import '../../models/product.dart';

import '../shared/dialog_utils.dart';

class UserProductListTile extends StatelessWidget {
  final Product product;

  const UserProductListTile(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
        radius: 30,
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            buildEditButton(context),
            buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

  //Widget chức năng xóa khi nhấn vào
  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
      showConfirmDialog(context, 'Bạn có muốn xóa sản phẩm này?').then((confirmed) {
        if (confirmed != null && confirmed) {
          context.read<ProductsManager>().deleteProduct(product.id!);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  'Sản phẩm đã được xóa',
                  textAlign: TextAlign.center,
                ),
              ),
            );
        }
      });
    },
      color: Theme.of(context).colorScheme.error,
    );
  }

  //Widget chức năng chỉnh sửa hoặc thêm mới khi nhấn vào
  Widget buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
          arguments: product.id,
        );
      },
      color: Theme.of(context).primaryColor,
    );
  }

}
