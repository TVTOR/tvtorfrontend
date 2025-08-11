class RegisterResponse {
  bool? success;
  Data? data;
  String? message;
  int? statusCode;

  RegisterResponse({this.success, this.data, this.message, this.statusCode});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
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
  String? password;
  bool? status;
  bool? isDeleted;
  String? userType;
  List<LocationData>? locationData;
  String? token;

  Data({
    this.sId,
    this.name,
    this.surname,
    this.email,
    this.password,
    this.status,
    this.isDeleted,
    this.userType,
    this.locationData,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      sId: json['_id'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      password: json['password'],
      status: json['status'],
      isDeleted: json['isDeleted'],
      userType: json['userType'],
      locationData: json['locationData'] != null
          ? (json['locationData'] as List)
          .map((item) => LocationData.fromJson(item))
          .toList()
          : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['surname'] = surname;
    data['email'] = email;
    data['password'] = password;
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    data['userType'] = userType;
    if (locationData != null) {
      data['locationData'] = locationData!.map((v) => v.toJson()).toList();
    }
    data['token'] = token;
    return data;
  }
}

class LocationData {
  String? sId;
  String? subject;

  LocationData({this.sId, this.subject});

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      sId: json['_id'],
      subject: json['subject'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['subject'] = subject;
    return data;
  }
}
