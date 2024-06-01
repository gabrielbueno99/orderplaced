import 'dart:async';
import 'package:flutter/material.dart';
import '../../provider/cardprovider.dart';
import 'package:provider/provider.dart';
import 'package:orderplaced/widgets/shopping_button.dart';
import 'package:orderplaced/widgets/product.dart';
import 'package:firebase_database/firebase_database.dart';

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  var productss = [];


  List<Product> product = [
    Product(name: 'Camisa Flutter', price: 59.90),
    Product(name: 'Caneca Flutter', price: 29.90),
    Product(name: 'Chapéu Flutter', price: 39.90),
  ];


  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),

        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(5.0),
            child: ShoppingButton(callback: (){}, contextOfCard: context),
          )
        ],
      ),
      body: ListView(
        children: List.generate(product.length, (index) {
          Product products = product[index];
          return ProductWidget(
            name: products.name,
            price: products.price,
          );
        }),
      ),
    );
  }
}



