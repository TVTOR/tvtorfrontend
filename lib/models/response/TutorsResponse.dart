import 'package:fluttertvtor/models/response/locationresponse.dart';
import 'package:fluttertvtor/models/response/userresponse.dart' as user;

import 'SubjectResponse.dart';

class TutorsResponse {
  bool? status;
  Data? data;
  String? message;
  int? statusCode;

  TutorsResponse({this.status, this.data, this.message, this.statusCode});

  factory TutorsResponse.fromJson(Map<String, dynamic> json) {
    return TutorsResponse(
      status: json['success'],
      data: json['data'] != null ? Data.fromJson(json['data']) : Data(data: []),
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['statusCode'] = statusCode;
    return data;
  }
}

class Data {
  List<TutorsItem>? data;
  int? total;

  Data({this.data, this.total});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json['data'] != null
          ? (json['data'] as List).map((v) => TutorsItem.fromJson(v)).toList()
          : [],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class TutorsItem {
  List<String>? location;
  List<String>? subjects;
  bool? status;
  bool? isDeleted;
  List<String>? subjectId;
  List<SubjectItem>? subjectData;
  List<String>? locationData;
  List<DataItem>? locationList;
  String? managerId;
  String? userType;
  String? comment;
  String? sId;
  String? name;
  String? availability;
  String? surname;
  String? imageUrl;
  String? email;
  String? password;
  String? description;
  num? mobileNumber;
  int? code;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isShowDelete;

  TutorsItem({
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
    this.comment,
    this.name,
    this.isShowDelete,
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

  factory TutorsItem.fromJson(Map<String, dynamic> json) {
    return TutorsItem(
      location: json['location'] != null
          ? List<String>.from(json['location'])
          : (json['loctaion'] != null
              ? List<String>.from(json['loctaion'])
              : null),
      subjects: json['subjects'] != null
          ? List<String>.from(json['subjects'])
          : (json['subjects'] != null
              ? List<String>.from(json['subjects'])
              : null),
      status: json['status'],
      isDeleted: json['isDeleted'],
      comment: json['comment'] ?? '',
      description: json['description'],
      isShowDelete: json['isShowDelete'] ?? false,
      availability: json['availability'],
      subjectId: json['subjectId'] != null
          ? List<String>.from(json['subjectId'])
          : null,
      subjectData: json['subjectData'] != null
          ? (json['subjectData'] as List)
              .map((v) => SubjectItem.fromJson(v))
              .toList()
          : [],
      locationData: json['locationData'] != null
          ? List<String>.from(json['locationData'])
          : null,
      locationList: json['locationList'] != null
          ? (json['locationList'] as List)
              .map((i) => DataItem.fromJson(i))
              .toList()
          : [],
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
    data['location'] = location;
    data['subjects'] = subjects;
    data['status'] = status;
    data['isDeleted'] = isDeleted;
    data['subjectId'] = subjectId;
    data['subjectData'] =
        subjectData != null ? subjectData!.map((v) => v.toJson()).toList() : [];
    data['locationData'] = locationData;
    data['description'] = description;
    data['managerId'] = managerId;
    data['userType'] = userType;
    data['_id'] = sId;
    data['name'] = name;
    data['surname'] = surname;
    data['imageUrl'] = imageUrl;
    data['email'] = email;
    data['password'] = password;
    data['mobileNumber'] = mobileNumber;
    data['code'] = code;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isShowDelete'] = isShowDelete;
    data['__v'] = iV;
    if (locationList != null) {
      data['locationList'] = locationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
