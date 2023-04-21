import 'package:flutter/foundation.dart';

import '../../models/cart_item.dart';
import '../../models/product.dart';

class CartManager with ChangeNotifier {
  
  Map<String, CartItem> _items = {};

  int get productCount {
    return _items.length;
  }

  List<CartItem> get products {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, CartItem>> get productEntries {
    return {..._items}.entries;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  //Thêm sl từ dropdown Productlisttile
  void addItem(Product product, int quantity) {
    //Cộng 1 nếu sản phẩm đã tồn tại
    if(_items.containsKey(product.id)) {
      //Change quantity...
      _items.update(
        product.id!,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity + quantity,
        ),
      );
    } else {
      //Thêm mới nếu sản phẩm chưa có + cập nhật ngày thêm
      _items.putIfAbsent(
        product.id!,
        () => CartItem(
          //id
          id: 'c${DateTime.now().toIso8601String()}',
          title: product.title,
          price: product.price * (1 - (product.discount ?? 0) / 100), // tính giá khuyến mãi
          //Thêm sl
          quantity: quantity,
          //Image
          imageUrl: product.imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if(!_items.containsKey(productId)) {
      return;
    }
    if(_items[productId]?.quantity as num > 1) {
      _items.update(
        productId,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity - 1
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}