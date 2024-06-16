import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:orderplaced/routes/public/closeOrder.dart';

import 'package:orderplaced/db/services/DatabaseService.dart';

import 'package:orderplaced/db/models/orders.dart';


class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Arguments;
    final String orderId = args.orderId;
    final DatabaseService _databaseService = DatabaseService();
    print(orderId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Pedido'),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _databaseService.getOrderById(orderId),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os detalhes'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Pedido não encontrado'));
          }

          Map<String, dynamic> orderData = snapshot.data!.data()!;
          Orders order = Orders.fromJson(orderData);

          Timestamp created = order.created;
          bool finished = order.finished;
          List<dynamic> productsData = order.products;

          return ListView(
            children: [
              ListTile(
                title: Text('Criado em: ${created.toDate()}'),
              ),
              ListTile(
                title: Text('Status: ${finished == false ? 'Preparando' : 'Finalizado'}'),
              ),
              for (var product in productsData)
                ListTile(
                  title: Text(product.name),
                  subtitle: Text('Quantidade: ${product.qty} | Valor: R\$ ${product.value}'),
                ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/home',
                    arguments: Arguments(orderId),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(239, 24, 27, 97)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  )),
                ),
                child: Text(
                  'Voltar ao menu inicial!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
