import 'package:flutter/material.dart';

class AdminArea extends StatefulWidget {
  const AdminArea({super.key});

  @override
  State<AdminArea> createState() => _AdminAreaState();
}

class _AdminAreaState extends State<AdminArea> {
  final List<Map<String, dynamic>> _configuracoes = [
    {
      "titulo": "Cadastrar produto",
      "icone": Icons.add_shopping_cart,
      "trailing": Icon(Icons.arrow_forward_ios),
      "onTap": "/product"
    },
    {
      "titulo": "Pedidos abertos",
      "icone": Icons.check_box_rounded,
      "trailing": Icon(Icons.arrow_forward_ios),
      "onTap": "/orderstodo"
    },
    {
      "titulo": "Home",
      "icone": Icons.home,
      "trailing": Icon(Icons.arrow_forward_ios),
      "onTap": "/home"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemCount: _configuracoes.length,
          itemBuilder: (context, index){
              final config = _configuracoes[index];
              return ListTile(
                leading: Icon(config["icone"]),
                title: Text(config["titulo"]),
                trailing: config["trailing"],
                onTap: (){Navigator.pushNamed(context, config["onTap"]);},
              );
          })
    );
  }
}
