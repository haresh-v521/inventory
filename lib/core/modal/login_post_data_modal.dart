import 'dart:convert';

LoginUsers loginUsersFromJson(String str) => LoginUsers.fromJson(json.decode(str));

String loginUsersToJson(LoginUsers data) => json.encode(data.toJson());

class LoginUsers {
  LoginUsers({
    required this.status,
    required this.token,
    required this.tokenType,
    required this.user,
  });

  bool status;
  String token;
  String tokenType;
  User user;

  factory LoginUsers.fromJson(Map<String, dynamic> json) => LoginUsers(
    status: json["status"],
    token: json["token"],
    tokenType: json["token_type"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "token": token,
    "token_type": tokenType,
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.birthDate,
    required this.gender,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime birthDate;
  String gender;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    birthDate: DateTime.parse(json["birth_date"]),
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "birth_date": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
    "gender": gender,
  };
}
