import 'package:flutter/material.dart';
import '../../provider/cardprovider.dart';
import 'package:provider/provider.dart';

class ShoppingButton extends StatelessWidget {
  final VoidCallback callback;
  final BuildContext contextOfCard;
  const ShoppingButton({super.key, required this.callback, required this.contextOfCard});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(contextOfCard);
    return Stack(
      children: [
        FloatingActionButton(
          onPressed: callback,
          child: Icon(Icons.add_shopping_cart),
          backgroundColor: Color.fromARGB(249, 183, 223, 167),
        ),
        Positioned(
          top: 3.0,
          right: 3.0,
          child: Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Text(
              cartProvider.itemCount.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
