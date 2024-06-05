import 'package:flutter/material.dart';
import 'package:market/widgets/product.dart';
import 'package:provider/provider.dart';
import '../widgets/cart.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final quantity = cart.getQuantity(product.id);
    print('Product ID: ${product.id}');
    print('Product Title: ${product.title}');
    print('Product Image Path: ${product.imagePath}');
    print('Product Price: ${product.price}');
    print('Product Quantity: $quantity');

    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(bottom: 5,top: 5),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 20),
          if (product.imagePath.isNotEmpty)
            Image.asset(
              product.imagePath,
              width: 100, // Ограничение ширины изображения
              height: 100,
              fit: BoxFit.cover,
            ),
          Text(product.title),
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Price: ${product.price.toString()} \$'),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (quantity > 0) {
                      cart.removeSingleItem(product.id);
                    }
                  },
                ),
                Text('$quantity'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (product.id == 'p2' && quantity >= 1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('You can only add one English Course.'),
                        ),
                      );
                      return;
                    }
                    cart.addItem(product.id, product.price, product.title);
                  },
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
