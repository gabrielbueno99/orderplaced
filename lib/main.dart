import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:orderplaced/routes/public/home.dart';
import 'package:orderplaced/routes/public/login.dart';
import 'package:orderplaced/routes/public/order.dart';
import 'package:orderplaced/routes/private/adminsettings.dart';
import 'package:orderplaced/routes/private/addProduct.dart';
import 'package:orderplaced/provider/cardprovider.dart';
import 'package:provider/provider.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(),
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => Login(),
        '/order': (context) => Orders(),
        '/admin' : (context) => AdminArea(),
        '/product' : (context) => AddProduct()
      }
      ,
    );
  }
}


