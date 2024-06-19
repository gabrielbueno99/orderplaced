import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:orderplaced/db/models/orderTimer.dart';
import 'package:orderplaced/provider/timerProvider.dart';

import 'package:orderplaced/db/models/orders.dart';
import 'package:orderplaced/db/services/DatabaseService.dart';
import 'package:provider/provider.dart';

class OrdersTodo extends StatefulWidget {
  const OrdersTodo({Key? key}) : super(key: key);

  @override
  _OrdersTodoState createState() => _OrdersTodoState();
}

class _OrdersTodoState extends State<OrdersTodo> {
  final DatabaseService _databaseService = DatabaseService();
  List<bool> prepare = [
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TimerProvider(),
      child: Scaffold(
        body: Consumer<TimerProvider>(
          builder: (context, timerProvider, child) {
            return StreamBuilder<QuerySnapshot>(
              stream: _databaseService.getOpenOrders(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar os pedidos'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('Nenhum pedido em aberto'));
                }

                List<Orders> pedidos = snapshot.data!.docs
                    .map((doc) => Orders.fromJson(doc.data() as Map<String, dynamic>))
                    .toList();

                if (prepare.length != pedidos.length) {
                  prepare = List.generate(pedidos.length, (index) => false);
                }

                return ListView.separated(
                  itemCount: pedidos.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    Orders order = pedidos[index];
                    String id =  '';
                    _databaseService.getOrderIdByTimestamp(order.created).then((orderId) {
                      if (orderId != null) {
                        id = orderId;
                      } else {
                        return;
                      }
                    });

                    OrderTimer orderTimer = TimerProvider().timers[id] ?? OrderTimer(orderId: id);
                    Color cardColor = prepare[index] ? Colors.green : Color.fromARGB(239, 24, 27, 97);
                    return Card(
                      color: cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4, // Sombra
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Center(
                          child: Text(
                            'Pedido',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white
                            ),
                          ),
                        ),
                        subtitle: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (var product in order.products)
                                Text(
                                  '${product.name} - Quantidade: ${product.qty} - Valor: R\$ ${product.value}',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white
                                  ),
                                ),
                              SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _initPrepare(index);

                                  if (!orderTimer.isRunning) {
                                    TimerProvider timerProvider = TimerProvider();
                                    timerProvider.initTimer(id);
                                  }
                                },
                                icon: Icon(Icons.play_arrow),
                                label: Text('Iniciar Preparo'),

                              ),
                              if (!order.finished)
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _finishPrepare(id);
                                  },
                                  icon: Icon(Icons.close),
                                  label: Text('Finalizar'),
                                ),
                              if (orderTimer.isRunning)
                                Text('Tempo decorrido: ${orderTimer.elapsedTime!.inSeconds} segundos'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _initPrepare(int index) {
    setState(() {
      prepare[index] = true;
    });
  }

  void _finishPrepare(String orderId) {
    final updates = {
      'finished': true,
    };
    _databaseService.updateOrderField(orderId, updates);
  }
}


