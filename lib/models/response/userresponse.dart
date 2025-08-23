import 'package:fluttertvtor/models/response/locationresponse.dart';

class UserResponse {
  bool? success;
  Data? data;
  String? message;
  int? statusCode;

  UserResponse({this.success, this.data, this.message, this.statusCode});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  List<String>? location;
  List<String>? subjects;
  bool? status;
  bool? isDeleted;
  List<String>? subjectId;
  List<String>? subjectData;
  List<dynamic>? locationData;
  List<DataItem>? locationList;
  String? managerId;
  String? userType;
  String? sId;
  String? name;
  String? availability;
  String? surname;
  String? imageUrl;
  String? email;
  String? password;
  String? description;
  int? mobileNumber;
  int? code;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({
    this.location,
    this.subjects,
    this.status,
    this.isDeleted,
    this.subjectId,
    this.subjectData,
    this.locationData,
    this.managerId,
    this.userType,
    this.sId,
    this.name,
    this.surname,
    this.imageUrl,
    this.email,
    this.password,
    this.availability,
    this.mobileNumber,
    this.code,
    this.description,
    this.locationList,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      location: json['location'] != null
          ? List<String>.from(json['location'])
          : (json['loctaion'] != null
              ? List<String>.from(json['loctaion'])
              : null),
      subjects:
          json['subjects'] != null ? List<String>.from(json['subjects']) : null,
      status: json['status'],
      isDeleted: json['isDeleted'],
      description: json['description'],
      availability: json['availability'],
      subjectId: json['subjectId'] != null
          ? List<String>.from(json['subjectId'])
          : null,
      subjectData: json['subjectData'] != null
          ? (json['subjectData'] as List).map((e) {
        if (e is String) {
          return e;
        } else if (e is Map<String, dynamic>) {
          return e['subject']?.toString() ?? '';
        } else {
          return '';
        }
      }).toList()
          : null,
      locationData: json['locationData'] != null
          ? List<dynamic>.from(json['locationData'])
          : null,
      locationList: json['locationList'] != null
          ? (json['locationList'] as List)
              .map((i) => DataItem.fromJson(i))
              .toList()
          : null,
      managerId: json['managerId'],
      userType: json['userType'],
      sId: json['_id'],
      name: json['name'],
      surname: json['surname'],
      imageUrl: json['imageUrl'],
      email: json['email'],
      password: json['password'],
      mobileNumber: json['mobileNumber'],
      code: json['code'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location;
    }
    if (subjects != null) {
      data['subjects'] = subjects;
    }
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    if (subjectId != null) {
      data['subjectId'] = subjectId;
    }
    if (subjectData != null) {
      data['subjectData'] = subjectData;
    }
    if (locationData != null) {
      data['locationData'] = locationData;
    }
    data['description'] = description;
    data['managerId'] = managerId;
    data['userType'] = userType;
    data['_id'] = sId;
    data['name'] = name;
    data['surname'] = surname;
    data['imageUrl'] = imageUrl;
    data['email'] = email;
    data['password'] = password;
    data['availability'] = availability;
    data['mobileNumber'] = mobileNumber;
    data['code'] = code;
    if (locationList != null) {
      data['locationList'] = locationList!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}



