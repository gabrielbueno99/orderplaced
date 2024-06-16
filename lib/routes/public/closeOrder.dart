import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orderplaced/db/models/orders.dart';
import '../../provider/cardprovider.dart';
import 'package:provider/provider.dart';
import 'package:orderplaced/db/services/DatabaseService.dart';

class Arguments {
  final String orderId;

  Arguments(this.orderId);
}

class Closeorder extends StatefulWidget {
  const Closeorder({super.key});

  @override
  State<Closeorder> createState() => _CloseorderState();
}

class _CloseorderState extends State<Closeorder> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: cartProvider.products.length,
                itemBuilder: (context, index) {
                  final product = cartProvider.products[index];
                  return ListTile(
                    title: Text(product['product']),
                    subtitle: Text(
                        'Quantidade: ${product['qty']} | Valor: R\$ ${product['value']}'),
                  );
                },
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    bool success = await addOrder(cartProvider.products);
                    if(success) {
                      cartProvider.endCount();
                      cartProvider.clearCart();
                    } else {
                      return;
                    }
                  },
                  child: Text('Realizar Pedido'), // Passado como argumento
                ),
                ElevatedButton(
                  onPressed: () {
                  },
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<ProductInOrder> convertProducts(List<Map<String, dynamic>> products) {
    return products.map((prd) => ProductInOrder.fromJson(prd)).toList();
  }

  addOrder(products) async {
    Timestamp timestamp = Timestamp.now();
    final List<ProductInOrder> productsInOrder = convertProducts(products);

    try {
      Orders order = Orders(created: timestamp, finished: false, products: productsInOrder);
      String orderId = await  _databaseService.addOrder(order);

      // Navegando para outra tela e passando o ID
      Navigator.pushNamed(
        context,
        '/orderdetail',
        arguments: Arguments(orderId), // Passando o ID como argumento
      );
    } catch (e) {
      print('Erro ao adicionar order: $e');
    }
  }
}

