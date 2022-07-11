import 'dart:convert';

UpdateProduct updateProductFromJson(String str) =>
    UpdateProduct.fromJson(json.decode(str));

String updateProductToJson(UpdateProduct data) => json.encode(data.toJson());

class UpdateProduct {
  UpdateProduct({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory UpdateProduct.fromJson(Map<String, dynamic> json) => UpdateProduct(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.mrp,
    required this.selling,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.img,
  });

  int id;
  String name;
  String mrp;
  String selling;
  String description;
  dynamic image;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic img;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        mrp: json["mrp"],
        selling: json["selling"],
        description: json["description"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mrp": mrp,
        "selling": selling,
        "description": description,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "img": img,
      };
}
