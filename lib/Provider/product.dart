import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setValue(bool oldStatus) {
    isFavorite = oldStatus;
  }

  Future<void> istoggleFavorite(String token, String userId) async {
    final url =
        'https://flutterstore-f9ed2.firebaseio.com/userFavourite/$userId/$id.json?auth=$token';
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final responce = await http.put(
        url,
        body: json.encode(isFavorite),
      );
      if (responce.statusCode >= 400) {
        _setValue(oldStatus);
      }
    } catch (error) {
      _setValue(oldStatus);

      notifyListeners();
    }
  }
}
