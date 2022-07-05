class PostData {
  bool? status;
  String? message;
  Data? data;
  String? token;

  PostData({this.status, this.message, this.data, this.token});

  PostData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Data {
  String? name;
  String? email;
  String? gender;
  String? image;
  String? birthDate;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      { this.name, this.email, this.gender,this.image, this.birthDate, this.updatedAt, this.createdAt, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    image = json['image'];
    birthDate = json['birth_date'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['image'] = image;
    data['birth_date'] = birthDate;
    data['updated_at'] =updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
