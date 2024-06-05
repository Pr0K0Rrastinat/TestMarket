import 'package:flutter/material.dart';
import 'package:market/components/ProductTile.dart';
import 'package:provider/provider.dart';
import 'products.dart';
import 'cart.dart';
import 'cart_screen.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).items;
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Product List'),
        
      ),
      body: Padding(
        
        padding: const EdgeInsets.only(bottom:15),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (ctx, i) => ProductTile(
            product: products[i],
          ),
          
        ),
      ),
    );
  }
}
