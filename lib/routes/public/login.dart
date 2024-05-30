import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
  late FirebaseAuth _auth;

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
    print('chamou');
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    print('inicializou');
    print(_auth);
  }

  Future _authenticate() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerSenha.text
      );
      return true;
    }catch(e){
      print('bateu no catch');
      print(e);
      return false;
    }
  }
}
