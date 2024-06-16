import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orderplaced/db/models/product.dart';
import 'package:orderplaced/db/models/orders.dart';

const String PRODUCT_COLLECTIN_REFERENCE = 'products';
const String ORDER_COLLECTION_REFERENCE = 'orders';

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

  void deleteProduct(String productId) {
    _productRef.doc(productId).delete();
  }

  Stream<QuerySnapshot> getOrders() {
    return _firestore.collection('orders').snapshots();
  }

  Stream<QuerySnapshot> getOpenOrders() {
    return _firestore.collection('orders')
        .where('finished', isEqualTo: false)
        .snapshots();
  }

  Future<String?> getOrderIdByTimestamp(Timestamp timestamp) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('created', isEqualTo: timestamp)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      print(querySnapshot.docs.first.id);
      return querySnapshot.docs.first.id;
    } else {
      return null;
    }
  }

  Future<void> updateOrderField(String orderId, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection(ORDER_COLLECTION_REFERENCE).doc(orderId).update(updates);
    } catch (e) {
      print('Erro ao atualizar pedido $orderId: $e');
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getOrderById(String orderId) {
    return _firestore.collection('orders').doc(orderId).snapshots();
  }

  Future <String> addOrder(Orders order) async {
    final docRef = await _firestore.collection('orders').add(order.toJson());
    return docRef.id;
  }

}