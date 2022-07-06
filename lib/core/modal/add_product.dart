import 'dart:convert';

Add addFromJson(String str) => Add.fromJson(json.decode(str));

String addToJson(Add data) => json.encode(data.toJson());

class Add {
  Add({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  Data data;

  factory Add.fromJson(Map<String, dynamic> json) => Add(
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
    required this.name,
    required this.mrp,
    required this.selling,
    required this.description,
    required this.image,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.img,
  });

  String name;
  String mrp;
  String selling;
  String description;
  String image;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  String img;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    mrp: json["mrp"],
    selling: json["selling"],
    description: json["description"],
    image: json["image"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mrp": mrp,
    "selling": selling,
    "description": description,
    "image": image,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
    "img": img,
  };
}
