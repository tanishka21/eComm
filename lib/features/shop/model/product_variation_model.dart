class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  /// create empty func for clean code
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  toJson() {
    return {
      'id': id,
      'image': image,
      'description': description,
      'price': price,
      'salePrice': salePrice,
      'sku': sku,
      'stock': stock,
      'attributeValues': attributeValues,
    };
  }

  /// Map json oriented document snapshot from firebase to Model
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationModel.empty();
    print('================>>>>>>>ProductVariationModel $data');
    return ProductVariationModel(
      id: data['id'] ?? '',
      price: double.parse((data['price'] ?? 0.0).toString()),
      sku: data['sku'] ?? '',
      stock: data['stock'] ?? 0,
      salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
      image: data['image'] ?? '',
      attributeValues: Map<String, String>.from(data['attributeValues']),
    );
  }
}
