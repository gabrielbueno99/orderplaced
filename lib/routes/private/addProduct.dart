import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final _controllerProduto = TextEditingController();
  final _controllerValor = TextEditingController();
  final _controllerCategoria = TextEditingController();

  @override
  void dispose() {
    _controllerProduto.dispose();
    _controllerValor.dispose();
    _controllerCategoria.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _controllerProduto,
                decoration: InputDecoration(labelText: "Nome do produto"),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return "Por favor, digite o nome do produto";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _controllerValor,
                obscureText: true,
                decoration: InputDecoration(labelText: "produto"),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return "Por favor, digite o valor do produto";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _controllerCategoria,
                obscureText: true,
                decoration: InputDecoration(labelText: "Categoria"),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return "Por favor, digite sua senha";
                  }
                  return null;
                },
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/admin');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  )),
                ),
                child: Text('Cadastrar', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
