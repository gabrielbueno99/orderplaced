import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _controllerEmail = TextEditingController();
  final _controllerSenha = TextEditingController();
  String _errorMessage = '';
  final CollectionReference productCollection =
  FirebaseFirestore.instance.collection("users");

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerSenha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initFirebase(context);
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
                controller: _controllerEmail,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return "Por favor, digite seu email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Text(
                _errorMessage ?? "", // Display error message if it exists
                style: TextStyle(color: Colors.red),
              ),
              TextFormField(
                controller: _controllerSenha,
                obscureText: true,
                decoration: InputDecoration(labelText: "Senha"),
                validator: (value) {
                  print(value);
                  if (value?.isEmpty ?? true) {
                    return "Por favor, digite sua senha";
                  }
                  return null;
                },
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () async{
                  bool autorized = await _authenticate();
                  Navigator.pushNamed(context, '/admin');
                  if(autorized) {
                    Navigator.pushNamed(context, '/admin');
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(239, 24, 27, 97)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  )),
                ),
                child: Text('Login', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future <void> _initFirebase(context)async{
    final CollectionReference productCollection =
    FirebaseFirestore.instance.collection("products");
    print(productCollection);
    QuerySnapshot snapshot =
    await productCollection.where("description", isEqualTo: "").get();
    print(snapshot);
    print('inicializou');
  }

  Future _authenticate() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: 'gabrielpregss@gmail.com',
          password: '123456'
      );
      return true;
    }catch(e){
      print('bateu no catch');
      print(e);
      return false;
    }
  }
}
