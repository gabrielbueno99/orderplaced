import 'package:flutter/material.dart';
import '../../provider/cardprovider.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatefulWidget {
  final String name;
  final String description;
  final String price;

  ProductWidget({super.key, required this.name, required this.description, required this.price});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color.fromARGB(239, 24, 27, 97),
      ),
      child: Row(
        children: [
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                widget.description,
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              Text(
                widget.price,
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ],
          ),
          Spacer(),
          Stack(
            children: [
              FloatingActionButton(
                onPressed: () {
                  if (_itemCount > 0) {
                    setState(() => _itemCount--);
                    cartProvider.addProduct(widget.name, _itemCount, widget.price); // Call removeProduct method
                  }
                  print(cartProvider.products);
                },
                child: Icon(Icons.remove_shopping_cart),
                backgroundColor: Colors.red, // Distinguish remove button
                mini: true, // Use mini size for compact design
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() => _itemCount++);
                  cartProvider.addItem();
                  cartProvider.addProduct(widget.name, _itemCount, widget.price);
                  print(cartProvider.products);
                },
                child: Icon(Icons.add_shopping_cart),
                backgroundColor: Colors.white,
              ),
              if (_itemCount > 0)
                Positioned(
                  top: 4.0,
                  right: 4.0,
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      "$_itemCount",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}