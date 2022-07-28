import 'package:ecommerce/models/base_model.dart';

class Product extends BaseModel {
  @override
  int? id;
  static const String TABLE_NAME = "product";
  @override
  String tableName = "product";
  String name;

  Product({required this.name, this.id});

  @override
  BaseModel fromMap(Map<String, Object?> data) {
    return Product(
        name: (data["name"]?.toString() ?? ""), id: (data["id"] as int?) ?? 0);
  }

  @override
  Map<String, Object?> toMap() {
    return {"name": name};
  }

  factory Product.fromMap(Map<String, Object?> data) {
    return Product(
        name: (data["name"]?.toString() ?? ""), id: (data["id"] as int?) ?? 0);
  }
}
