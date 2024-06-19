import 'package:flutter/material.dart';
import 'package:orderplaced/db/services/DatabaseService.dart';
import 'package:orderplaced/widgets/product.dart';
import '../../db/models/product.dart';
import '../../provider/cardprovider.dart';
import 'package:provider/provider.dart';
import 'package:orderplaced/widgets/shopping_button.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final DatabaseService _databaseService = DatabaseService();


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
            child: ShoppingButton(callback: (){Navigator.pushNamed(context, '/closeorder');}, contextOfCard: context),
          )
        ],
      ),
      body: StreamBuilder(
        stream: _databaseService.getProducts(),
        builder: (context, snapshot) {
          List products = snapshot.data?.docs ?? [];
          if (products.isEmpty) {
            return const Center(
              child: Text('Não há produtos cadastrados'),
            );
          } else {
            return ListView.builder(
              itemCount: products.length,
                itemBuilder: (context, index) {
                Product product = products[index].data();
                return ProductWidget(name: product.product,description: product.description, price: product.value);
            });
          }
        },
      )
    );
  }
}