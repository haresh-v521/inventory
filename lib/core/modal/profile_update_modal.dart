import 'dart:convert';

ProfileUpdate profileUpdateFromJson(String str) =>
    ProfileUpdate.fromJson(json.decode(str));

String profileUpdateToJson(ProfileUpdate data) => json.encode(data.toJson());

class ProfileUpdate {
  ProfileUpdate({
    required this.status,
    required this.message,
    required this.user,
  });

  bool status;
  String message;
  Users user;

  factory ProfileUpdate.fromJson(Map<String, dynamic> json) => ProfileUpdate(
        status: json["status"],
        message: json["message"],
        user: Users.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
      };
}

class Users {
  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.birthDate,
    required this.gender,
  });

  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic birthDate;
  dynamic gender;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        birthDate: json["birth_date"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "birth_date": birthDate,
        "gender": gender,
      };
}
