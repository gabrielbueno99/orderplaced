import 'package:flutter/material.dart';
import '../../provider/cardprovider.dart';
import 'package:provider/provider.dart';

class Produto {
  final String nome;
  final double preco;

  Produto({required this.nome, required this.preco});
}

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<Produto> produtos = [
    Produto(nome: 'Camisa Flutter', preco: 59.90),
    Produto(nome: 'Caneca Flutter', preco: 29.90),
    Produto(nome: 'Chapéu Flutter', preco: 39.90),
  ];


  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Finalize no botão ao lado'),

        centerTitle: true,
        actions: [
          FloatingActionButton(
            onPressed: (){},
            child: Text(cartProvider.itemCount.toString()),
          )
        ],
      ),
      body: ListView(
        children: List.generate(produtos.length, (index) {
          Produto produto = produtos[index];
          return ProdutoWidget(
            nome: produto.nome,
            preco: produto.preco,
          );
        }),
      ),
    );
  }
}

class ProdutoWidget extends StatefulWidget {
  final String nome;
  final double preco;

  ProdutoWidget({required this.nome, required this.preco});

  @override
  State<ProdutoWidget> createState() => _ProdutoWidgetState();
}

class _ProdutoWidgetState extends State<ProdutoWidget> {
  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.nome,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.preco.toStringAsFixed(2),
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          Spacer(),
          Stack(
            children: [
              FloatingActionButton(
                onPressed: () {
                  setState(() => _itemCount++);
                  cartProvider.addItem();
                },
                child: Icon(Icons.add_shopping_cart),
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



