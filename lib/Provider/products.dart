import 'package:flutter/material.dart';
import 'package:shop/dummy_data.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = shopProducts;

  var _showFavorite = false;

  List<Product> get items {
    // if (_showFavorite) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  void productAdd() {
    // _items.add();

    notifyListeners();
  }

  List<Product> get favorite{
    return _items.where((prodItem)=>prodItem.isFavorite).toList();
  }

  // void showFavoriteOnly() {
  //   _showFavorite = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavorite = false;
  //   notifyListeners();
  // }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
}
