import 'package:flutter/material.dart';
import 'package:shop/dummy_data.dart';
import 'package:shop/model/http_exception.dart';
import './product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = shopProducts;

  var _showFavorite = false;

  List<Product> get items {
    // if (_showFavorite) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, this._items);

  Future<void> productAdd(Product product) async {
    final url =
        'https://flutterstore-f9ed2.firebaseio.com/products.json?auth=$authToken';
    try {
      final responce = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(responce.body)['name'],
      );

      _items.add(newProduct);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchProduct() async {
    var url =
        'https://flutterstore-f9ed2.firebaseio.com/products.json?auth=$authToken';
    try {
      final responce = await http.get(url);
      final extractedData = json.decode(responce.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return null;
      }

      url =
          'https://flutterstore-f9ed2.firebaseio.com/userFavourite/$userId.json?auth=$authToken';
      final favouriteresponce = await http.get(url);
      final favouriteData = json.decode(favouriteresponce.body);
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite:
                favouriteData == null ? false : favouriteData[prodId] ?? false,
            imageUrl: prodData['imageUrl']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product updateproduct) async {
    //it willl not const because we change it in compiler time
    try {
      final prodIndex = _items.indexWhere((prod) => prod.id == id);
      if (prodIndex >= 0) {
        final url =
            'https://flutterstore-f9ed2.firebaseio.com/products/$id.json?auth=$authToken';

        await http.patch(
          url,
          body: json.encode({
            'title': updateproduct.title,
            'description': updateproduct.description,
            'price': updateproduct.price,
            'imageUrl': updateproduct.imageUrl,
          }),
        );
        _items[prodIndex] = updateproduct;
        notifyListeners();
      } else {}
    } catch (error) {
      throw error;
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

  Future<void> removeProduct(String id) async {
    final url =
        'https://flutterstore-f9ed2.firebaseio.com/products/$id.json?auth=$authToken';
    final excistingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var excistingProduct = _items[excistingProductIndex];

    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();

    final responce = await http.delete(url);

    print(responce.statusCode);
    if (responce.statusCode >= 400) {
      //400  error means error happen in linking
      _items.insert(excistingProductIndex, excistingProduct);
      notifyListeners();

      throw HttpException('An error occurs');
    }

    excistingProduct = null;
  }
}
