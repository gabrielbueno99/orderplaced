
class Product {
  final String product;
  final String value;
  final String description;

  Product(
      {
        this.product = '',
        this.value = '',
        this.description = '',
    }
  );

  Product.fromJson(Map<String, dynamic?> json) : this(
    product: json['product']! as String,
    value: json['value']! as String,
    description: json['description']! as String
  );

  Product copyWith({
    String? product,
    String? value,
    String? description
  }) {
    return Product(product: this.product, value: this.value, description: this.description);
  }

  Map<String, Object?> toJson() {
    return {
      'product' : product,
      'value': value,
      'description': description
    };
  }

}