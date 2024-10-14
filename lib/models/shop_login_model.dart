class ShopLoginModel {
  late bool status;
  late String message;
  UserData? data; // Changed to nullable

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"] ?? ''; // Default value if message is null
    // Handle nullable 'data' field
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  // Named constructor to initialize from JSON
  UserData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    points = json["points"];
    credit = json["credit"];
    token = json["token"];
  }
}
