import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GlobalProvider with ChangeNotifier {
  List<Product> _products = [];

  int _itemCount = 1;

  get itemCount => _itemCount;

  List<Product> get products => _products;

  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _products = data.map((json) => Product.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  void addToCart(int productId) {
    Product? product = _products.firstWhere(
        (product) => product.id == productId,
        orElse: () => throw Exception('Product not found'));
    _cartItems.add(product);

    print(cartItems.length);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void increaseItemQuantity(Product product) {
  product.quantity++;
  notifyListeners();
}

void decreaseItemQuantity(Product product) {
  if (product.quantity > 1) {
    product.quantity--;
  }
  notifyListeners();
}

double calculateTotal() {
  double total = 0.0;
  for (Product product in _cartItems) {
    total += product.price * product.quantity;
  }
  return total;
}

}

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  int quantity; // Quantity property

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    this.quantity = 1, // Assign a default quantity of 1
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      image: json['image'],
    );
  }
}

