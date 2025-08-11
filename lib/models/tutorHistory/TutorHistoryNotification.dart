class TutorHistoryNotification {
  List<Data>? data;
  String? message;
  int? statusCode;
  bool? success;

  TutorHistoryNotification({this.data, this.message, this.statusCode, this.success});

  factory TutorHistoryNotification.fromJson(Map<String, dynamic> json) {
    return TutorHistoryNotification(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : [],
      message: json['message'],
      statusCode: json['statusCode'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['statusCode'] = statusCode;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? createdAt;
  List<String>? location;
  String? message;
  QueryData? queryData;
  List<String>? subject;
  List<String>? tmId;
  String? updatedAt;

  Data({
    this.id,
    this.createdAt,
    this.location,
    this.message,
    this.queryData,
    this.subject,
    this.tmId,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['_id'],
      createdAt: json['createdAt'],
      location: json['location'] != null ? List<String>.from(json['location']) : null,
      message: json['message'],
      queryData:
      json['queryData'] != null ? QueryData.fromJson(json['queryData']) : null,
      subject:
      json['subject'] != null ? List<String>.from(json['subject']) : [],
      tmId: json['tmId'] != null ? List<String>.from(json['tmId']) : [],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['createdAt'] = createdAt;
    data['message'] = message;
    data['updatedAt'] = updatedAt;
    data['tmId'] = tmId;
    if (location != null) {
      data['location'] = location;
    }
    if (queryData != null) {
      data['queryData'] = queryData!.toJson();
    }
    if (subject != null) {
      data['subject'] = subject;
    }
    return data;
  }
}

class QueryData {
  String? email;
  String? location;
  String? mobilenumber;
  String? name;
  String? question;
  String? subject;

  QueryData({
    this.email,
    this.location,
    this.mobilenumber,
    this.name,
    this.question,
    this.subject,
  });

  factory QueryData.fromJson(Map<String, dynamic> json) {
    return QueryData(
      email: json['email'],
      location: json['location'] != null ? json['location'] : "",
      mobilenumber: json['mobilenumber'],
      name: json['name'],
      question: json['question'],
      subject: json['subject'] != null ? json['subject'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['mobilenumber'] = mobilenumber;
    data['name'] = name;
    data['question'] = question;
    if (location != null) {
      data['location'] = location;
    }
    if (subject != null) {
      data['subject'] = subject;
    }
    return data;
  }
}
