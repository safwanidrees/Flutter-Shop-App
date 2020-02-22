import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get item {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cart) {
      total += cart.price * cart.quantity.toDouble();
    });

    return total;
  }

  void undo(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (excistingCartItem) => CartItem(
          id: excistingCartItem.id,
          title: excistingCartItem.title,
          price: excistingCartItem.price,
          quantity: excistingCartItem.quantity - 1,
        ),
      );
    }
    else{
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeItems(String productID) {
    _items.remove(productID);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      //chanage quatity
      _items.update(
        productId,
        (excistingItem) => CartItem(
          id: excistingItem.id,
          title: excistingItem.title,
          price: excistingItem.price,
          quantity: excistingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          title: title,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }
}
