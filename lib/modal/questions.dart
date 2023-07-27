import 'dart:convert';

QuestionModel questionModelFromJson(String str) =>
    QuestionModel.fromJson(json.decode(str));

String questionModelToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
  // final int? responseCode;
  // final List<Result>? results;
  bool? success;
  int? count;
  int? totalPage;
  List<Result>? results;

  QuestionModel({this.success, this.count, this.totalPage, this.results});

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        success: json['success'],
        count: json['count'],
        totalPage: json['totalPage'],

        //responseCode: json["response_code"],
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        //"response_code": responseCode,
        "success": success,
        "count": count,
        "totalPage": totalPage,

        //     if (this.pagination != null) {
        //   data['pagination'] = this.pagination!.toJson();
        // }
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  final String? category;
  final String? type;

  final String? question;
  final String? answer;
  final List<String>? options;

  Result({
    this.category,
    this.type,
    this.question,
    this.answer,
    this.options,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        category: json["category"]!,
        type: json["type"]!,
        question: json["question"],
        answer: json["answer"],
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "type": type,
        "question": question,
        "answer": answer,
        "options":
            options == null ? [] : List<String>.from(options!.map((x) => x)),
      };
}
