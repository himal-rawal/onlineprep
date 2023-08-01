class AppUrl {
  static const String baseUrl = "http://10.20.30.57:3001";

  String questionUrlMethod(String category) {
    return "$baseUrl/api/v1/questions/?category=$category";
  }

  static const String questionCategoriesUrl = "$baseUrl/api/v1/categories";
  static const String loginUrl = "$baseUrl/api/v1/auth/login";
  static const String userdata = '$baseUrl/api/v1/auth/me';
  static const String signUP = "$baseUrl/api/v1/auth/register";
  static const String score = "$baseUrl/api/v1/scores";
  String scoreRankingUrl(String category) {
    return "$baseUrl/api/v1/scores/$category/category";
  }

  String scoreHistory(String userId) {
    return "$baseUrl/api/v1/scores/$userId";
  }
}
