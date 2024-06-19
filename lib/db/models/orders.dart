import 'package:cloud_firestore/cloud_firestore.dart';

class ProductInOrder {
  final String name;
  final int qty;
  final String value;

  ProductInOrder({required this.name, required this.qty, required this.value});

  factory ProductInOrder.fromJson(Map<String, dynamic> json) {
    return ProductInOrder(
      name: json['product'] as String? ?? '',
      qty: json['qty'] as int,
      value: json['value'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': name,
      'qty': qty,
      'value': value,
    };
  }
}

class Orders{
  final Timestamp created;
  final bool finished;
  final List<ProductInOrder> products;

  Orders({
    required this.created,
    required this.finished,
    required this.products,
  });

  Orders.fromJson(Map<String, dynamic> json)
      :
        created = json['created'] as Timestamp,
        finished = json['finished'] as bool,
        products = (json['products'] as List<dynamic>)
            .map((productJson) => ProductInOrder.fromJson(productJson as Map<String, dynamic>))
            .toList();

  Orders copyWith({
    Timestamp? created,
    bool? finished,
    List<ProductInOrder>? products,
  }) {
    return Orders(
      created: created ?? this.created,
      finished: finished ?? this.finished,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created': created,
      'finished': finished,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }

  factory Orders.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
      final data = document.data();
      return Orders(
          created: data?["created"],
          finished: data?["finished"],
          products: data?["products"],
      );
  }
}