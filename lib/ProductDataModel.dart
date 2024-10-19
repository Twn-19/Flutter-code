class ProductDataModel {
  int? id;
  String? name;
  String? category;
  String? imageUrl;
  String? price;

  ProductDataModel(
      {this.id, this.name, this.category, this.imageUrl, this.price});

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    imageUrl = json['imageUrl'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['imageUrl'] = imageUrl;
    data['price'] = price;
    return data;
  }
}
