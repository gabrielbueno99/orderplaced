import 'package:flutter/material.dart';
import 'package:orderplaced/db/models/product.dart';
import 'package:orderplaced/db/services/DatabaseService.dart';
import 'package:orderplaced/widgets/modal.dart';

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
  DatabaseService _databaseService = DatabaseService();

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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                decoration: InputDecoration(labelText: "Categoria"),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return "Por favor, digite sua senha";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  createProduct();
                },

                child: Text('Cadastrar', style: TextStyle(color: Colors.white),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(239, 24, 27, 97)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future createProduct() async {
   try {
     Product product = Product(product: _controllerProduto.text, value: _controllerValor.text, description: _controllerCategoria.text);
     _databaseService.addProduct(product);
     showDialog(context: context, builder: (BuildContext context){
       return ConfirmationDialog(title: 'Tudo certo!', message: 'Produto adicionado com sucesso');
     });
   }catch (e) {
     showDialog(context: context, builder: (BuildContext context){
       return ConfirmationDialog(title: 'Oops!', message: 'Algo deu errado');
     });

   }

  }


  showDialogconfirmation() {

  }
}
