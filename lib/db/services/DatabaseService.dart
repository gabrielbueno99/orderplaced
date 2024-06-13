import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orderplaced/db/models/product.dart';

const String PRODUCT_COLLECTIN_REFERENCE = 'products';

class DatabaseService {

  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _productRef;

  DatabaseService() {
    _productRef = _firestore.collection(PRODUCT_COLLECTIN_REFERENCE).withConverter<Product>(
        fromFirestore: (snapshots, _)=> Product.fromJson(snapshots.data()!,),
        toFirestore: (product,_)=> product.toJson());
  }


  Stream<QuerySnapshot> getProducts() {
    return _productRef.snapshots();
  }

  void addProduct(Product product) async{
    _productRef.add(product);
  }

  void updateProduct(String productId, Product product) {
    _productRef.doc(productId).update(product.toJson());
  }

  void deletProduct(String productId) {
    _productRef.doc(productId).delete();
  }

}