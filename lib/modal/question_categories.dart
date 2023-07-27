import 'dart:convert';

QuestionCategories questioncategoryModelFromJson(String str) =>
    QuestionCategories.fromJson(json.decode(str));

class QuestionCategories {
  //List<TriviaCategories>? triviaCategories;
  List<Categories>? categories;

  QuestionCategories({this.categories});

  factory QuestionCategories.fromJson(Map<String, dynamic> json) =>
      QuestionCategories(
        categories: json["results"] == null
            ? []
            : List<Categories>.from(
                json["results"].map((x) => Categories.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['results'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? id;
  String? title;
  String? photo;

  Categories({this.id, this.title, this.photo});

  factory Categories.fromJson(Map<String, dynamic> json) =>
      Categories(id: json["id"], title: json["title"], photo: json['photo']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['photo'] = photo;
    return data;
  }
}
