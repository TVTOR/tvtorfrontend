class LoginResponse {
  bool? success;
  Data? data;
  String? message;
  int? statusCode;

  LoginResponse({this.success, this.data, this.message, this.statusCode});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['statusCode'] = statusCode;
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? surname;
  String? email;
  String? token;
  String? userType;

  Data({
    this.sId,
    this.name,
    this.surname,
    this.email,
    this.token,
    this.userType,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      sId: json['_id'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      token: json['token'],
      userType: json['userType'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['surname'] = surname;
    data['email'] = email;
    data['token'] = token;
    data['userType'] = userType;
    return data;
  }
}
