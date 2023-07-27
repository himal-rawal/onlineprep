class UserModel {
  bool? sucess;
  Users? data;
  UserModel({this.sucess, required this.data});
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        sucess: json['success'],
        data: json['data'] != null ? Users.fromJson(json['data']) : null,
      );
}

class Users {
  String id;
  String role;
  String email;
  String username;

  Users(
      {required this.email,
      required this.id,
      required this.role,
      required this.username});

  factory Users.fromJson(Map<String, dynamic> json) => Users(
      email: json['email'],
      role: json['role'],
      username: json['username'],
      id: json['_id']);
}

class UserModelResponse {
  bool? sucess;
  String? token;

  UserModelResponse({this.token, this.sucess});

  UserModelResponse.fromJson(Map<String, dynamic> json) {
    sucess = json['success'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sucess'] = sucess;
    data['token'] = token;
    return data;
  }
}
