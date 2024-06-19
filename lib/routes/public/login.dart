import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerSenha.dispose();
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
                _errorMessage ?? "",
                style: TextStyle(color: Colors.red),
              ),
              TextFormField(
                controller: _controllerSenha,
                obscureText: true,
                decoration: InputDecoration(labelText: "Senha"),
                validator: (value) {
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

  Future _authenticate() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerSenha.text
      );
      return true;
    }catch (e){
      return false;
    }
  }
}
