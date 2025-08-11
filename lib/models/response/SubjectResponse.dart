class SubjectResponse {
  bool? success;
  Data? data;
  String? message;
  int? statusCode;

  SubjectResponse({this.success, this.data, this.message, this.statusCode});

  factory SubjectResponse.fromJson(Map<String, dynamic> json) {
    return SubjectResponse(
      success: json['success'] ?? false,
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
  List<SubjectItem>? data;
  int? total;

  Data({this.data, this.total});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json['data'] != null
          ? (json['data'] as List)
          .map((v) => SubjectItem.fromJson(v))
          .toList()
          : null,
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

class SubjectItem {
  String? sId;
  String? subject;
  String? colorcode;
  String? managerId;
  String? createdAt;
  String? updatedAt;
  bool? isSelected;

  SubjectItem({
    this.isSelected,
    this.sId,
    this.subject,
    this.colorcode,
    this.managerId,
    this.createdAt,
    this.updatedAt,
  });

  factory SubjectItem.fromJson(Map<String, dynamic> json) {
    return SubjectItem(
      sId: json['_id'],
      subject: json['subject'],
      colorcode: json['colorcode'],
      managerId: json['managerId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isSelected: json['isSelected'] != null ? json['isSelected'] as bool : false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['subject'] = subject;
    data['colorcode'] = colorcode;
    data['managerId'] = managerId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isSelected'] = isSelected;
    return data;
  }
}
