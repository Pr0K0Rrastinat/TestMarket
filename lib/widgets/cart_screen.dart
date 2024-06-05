import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'cart.dart';
import 'products.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;
  int _orderAttempt = 0;

  void _orderNow() async {
    setState(() {
      _isLoading = true;
    });

    // Имитация задержки при выполнении запроса
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    _orderAttempt++;
    if (_orderAttempt % 2 == 0) {
      // Если попытка четная, показываем сообщение об ошибке
      showModalBottomSheet(
        context: context,
        builder: (ctx) => Container(
          height: 200,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 50),
              Text(
                'Order failed. Please try again!',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      );
    } else {
      // Если попытка нечетная, показываем сообщение об успешном заказе
      showModalBottomSheet(
        context: context,
        builder: (ctx) => Container(
          height: 200,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check, color: Colors.green, size: 50),
              Text(
                'Order placed successfully!',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).items;
    final cart = Provider.of<Cart>(context);
    final cartIsEmpty = cart.items.isEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.titleLarge!.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    child: _isLoading
                        ? SpinKitCircle(
                            color: Theme.of(context).primaryColor,
                            size: 24.0,
                          )
                        : Text('ORDER NOW'),
                    onPressed: cartIsEmpty || _isLoading ? null : _orderNow,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: cartIsEmpty
                ? Center(
                    child: Text(
                      'Your cart is empty!',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (ctx, i) {
                      final product = products[i];
                      final quantity = cart.getQuantity(product.id);
                      return Card(
                        child: ListTile(
                          title: Text('${product.title}   x$quantity'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  cart.removeItem(product.id);
                                },
                                icon: Icon(Icons.delete),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
