import 'package:flutter/material.dart';
import 'package:marketplace/models/product.dart';

class Shop extends ChangeNotifier {
  // products for sale
  final List<Product> _shop = [
    //product 1
    Product(
      name: "Product 1",
      price: 99.99,
      description: 'Item description..',
      imagePath: 'assets/servo.jpeg'
    ),

    //product 2
    Product(
      name: "Product 2",
      price: 99.99,
      description: 'Item description..',
       imagePath: 'assets/gps.jpg',
    ),

    //product 3
    Product(
      name: "Product 3",
      price: 99.99,
      description: 'Item description..', 
      imagePath: 'assets/nodemcu.jpg',
    ),

    //product 4
    Product(
      name: "Product 4",
      price: 99.99,
      description: 'Item description..', 
      imagePath: 'assets/ur.jpeg',
    ),
  ];

  // user cart
  final List<Product> _cart = [];

  // get product list
  List<Product> get shop => _shop;

  // add user cart
  List<Product> get cart => _cart;

  // add item to cart
  void addToCart(Product item) {
    _cart.add(item);
  }

  // remove item from cart
  void removeFromCart(Product item) {
    _cart.remove(item);
  }
}
