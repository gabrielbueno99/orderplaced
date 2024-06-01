import 'package:cloud_firestore/cloud_firestore.dart';

class Product {

  final docProd = FirebaseFirestore.instance.collection('products');
  final String id;
  final String product;
  final String value;
  final String description;

  Product(
      {
        this.id = '',
        this.product = '',
        this.value = '',
        this.description = '',
    }
  );

  static Product fromJson(Map<String, dynamic>json) => Product(
      id: json['id'],
      product: json['product'],
      value: json['value'],
      description: json['description']
  );

  Future createProduct(String product, String value, String description) async {

    var doc = docProd.doc();

    final json = {
      'id': docProd.id,
      'product':product,
      'value': value,
      'description': description,
    };

    await doc.set(json);

    return json;

  }


  Future updateProduct(id, String product, String value, String description) async {
    var doc = docProd.doc(id);

    final json = {
      'id': docProd.id,
      'product':product,
      'value': value,
      'description': description,
    };

    await doc.set(json);

    return json;
  }

  Stream<List<Product>> getProduct() {
    return docProd
        .snapshots()
        .map((snapshot)=> snapshot
        .docs.map((doc)=> Product
        .fromJson(doc.data()))
        .toList());
  }

}