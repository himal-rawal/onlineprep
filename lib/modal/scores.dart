class PostScoreResponse {
  bool? success;
  Data? data;

  PostScoreResponse({this.success, this.data});

  PostScoreResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? score;
  String? sId;
  String? category;
  String? user;
  String? username;
  String? categoryname;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.score,
      this.sId,
      this.category,
      this.user,
      this.username,
      this.categoryname,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    sId = json['_id'];
    category = json['category'];
    user = json['user'];
    username = json['username'];
    categoryname = json['categoryname'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['score'] = score;
    data['_id'] = sId;
    data['category'] = category;
    data['user'] = user;
    data['username'] = username;
    data['categoryname'] = categoryname;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
