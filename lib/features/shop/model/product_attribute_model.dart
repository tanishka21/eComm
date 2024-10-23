class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values});

  toJson() {
    return {'name': name, 'values': values};
  }

  ///
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    print('=========>>>>>>>>>>>>>>Product attribute model $data');

    if (data.isEmpty) return ProductAttributeModel();
    print('================>>>>>>>ProductAttributeModel $data');
    return ProductAttributeModel(
      name: data.containsKey('name') ? data['name'] : "",
      values: List<String>.from(data['values']),
    );
  }
}
