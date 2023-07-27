class AppUrl {
  String questionUrlMethod(String category) {
    return "http://10.20.30.57:3001/api/v1/questions/?category=$category";
  }

  static const String questionCategoriesUrl =
      "http://10.20.30.57:3001/api/v1/categories";
  static const String loginUrl = "http://10.20.30.57:3001/api/v1/auth/login";
  static const String userdata = 'http://10.20.30.57:3001/api/v1/auth/me';
  static const String signUP = "http://10.20.30.57:3001/api/v1/auth/register";
}
