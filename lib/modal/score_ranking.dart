import 'dart:convert';

RankingScore rankingModelFromJson(String str) =>
    RankingScore.fromJson(json.decode(str));

class RankingScore {
  bool? success;
  List<ScoreData>? data;

  RankingScore({this.success, this.data});

  factory RankingScore.fromJson(Map<String, dynamic> json) => RankingScore(
      success: json['sucess'],
      data: json["data"] == null
          ? []
          : List<ScoreData>.from(
              json['data']!.map((x) => ScoreData.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "sucess": success,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((e) => e.toJson()))
      };
}

class ScoreData {
  String? score;
  String? sId;
  String? category;
  String? user;
  String? username;
  String? categoryname;
  String? createdAt;
  String? createdAtTime;
  String? updatedAt;
  int? iV;

  ScoreData(
      {this.score,
      this.sId,
      this.category,
      this.user,
      this.username,
      this.categoryname,
      this.createdAt,
      this.createdAtTime,
      this.updatedAt,
      this.iV});

  factory ScoreData.fromJson(Map<String, dynamic> json) => ScoreData(
        score: json['score'],
        sId: json['_id'],
        category: json['category'],
        user: json['user'],
        username: json['username'],
        categoryname: json['categoryname'],
        createdAt: json['createdAt'].substring(0, 10),
        createdAtTime: json['createdAt'].substring(11, 19),
        updatedAt: json['updatedAt'],
        iV: json['__v'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
