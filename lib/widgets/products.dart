import 'package:flutter/material.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(id: 'p1', title: 'T-Shirt', price: 20.0,quantity:0,imagePath:'lib\\statics\\T-Shirt.jpg'),
    Product(id: 'p2', title: 'English Course', price: 100.0,quantity: 0,imagePath:'lib/statics/inggris.jpg'),
  ];

  List<Product> get items {
    return [..._items];
  }
}
