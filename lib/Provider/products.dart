import 'package:flutter/material.dart';
import 'package:shop/dummy_data.dart';
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

  Future<void> productAdd(Product product) async {
    const url = 'https://flutterstore-f9ed2.firebaseio.com/products.json';
    try {
     final responce= await http.post(
        url,
        body: json.encode(
        {
          'title':product.title,
          'description':product.description,
          'price':product.price,
          'isFavourite':product.isFavorite,
          'imageUrl':product.imageUrl,

        }
        ),

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

  Future<void> fetchProduct() async{
    const url = 'https://flutterstore-f9ed2.firebaseio.com/products.json';
    try{
   final responce= await http.get(url);
   final extractedData=json.decode(responce.body) as Map<String,dynamic>;
   final List<Product> loadedProducts=[];
   extractedData.forEach((prodId,prodData){
     loadedProducts.add(Product(
       id:prodId,
       title: prodData['title'],
       description: prodData['description'],
       price: prodData['price'],
       isFavorite: prodData['isFavourite'],
       imageUrl: prodData['imageUrl']
     ));
   });
   _items=loadedProducts;
    notifyListeners();
    }
    catch(error){
      throw error;
    }
  }

  void updateProduct(String id, Product updateproduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = updateproduct;
      notifyListeners();
    } else {}
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
