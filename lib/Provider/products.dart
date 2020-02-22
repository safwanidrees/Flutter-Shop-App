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

  void productAdd(Product product) {
    final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
    );

    _items.add(newProduct);

    notifyListeners();
  }

  void updateProduct(String id, Product updateproduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = updateproduct;
      notifyListeners();
    }
    else{
      
    }
  }

  List<Product> get favorite {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
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

  void removeProduct(String productID) {
    _items.removeWhere((prod) => prod.id == productID);
    notifyListeners();
  }
}
