import 'package:flutter/material.dart';
import 'package:orderplaced/routes/public/home.dart';
import 'package:orderplaced/routes/public/login.dart';
import 'package:orderplaced/routes/public/order.dart';
import 'package:orderplaced/routes/private/adminsettings.dart';
import 'package:orderplaced/routes/private/addProduct.dart';
import 'package:orderplaced/provider/cardprovider.dart';
import 'package:provider/provider.dart';

void main() {
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
        '/order': (context) => Order(),
        '/admin' : (context) => AdminArea(),
        '/product' : (context) => AddProduct()
      }
      ,
    );
  }
}


