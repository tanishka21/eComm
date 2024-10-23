class CartItemModel {
  String productId;
  String title;
  double? price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.price = 0.0,
    this.image,
    this.title = '',
    this.variationId = '',
    this.brandName,
    this.selectedVariation,
  });

  /// Empty cart
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  /// convert to Map Json
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'price': price,
      'image': image,
      'title': title,
      'variationId': variationId,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  /// create cart item from json map
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        productId: json['productId'],
        quantity: json['quantity'],
        title: json['title'],
        price: json['price']?.toDouble(),
        image: json['image'],
        variationId: json['variationId'],
        brandName: json['brandName'],
        selectedVariation: json['selectedVariation'] != null
            ? Map<String, String>.from(json['selectedVariation'])
            : null);
  }
}
