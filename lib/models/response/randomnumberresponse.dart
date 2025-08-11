class RandomNumberResponse {
  bool? success;
  Data? data;
  String? message;
  int? statusCode;

  RandomNumberResponse({
    this.success,
    this.data,
    this.message,
    this.statusCode,
  });

  factory RandomNumberResponse.fromJson(Map<String, dynamic> json) {
    return RandomNumberResponse(
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
  bool? used;
  String? sId;
  num? code;
  String? managerId;
  String? createdAt;
  String? updatedAt;
  num? iV;

  Data({
    this.used,
    this.sId,
    this.code,
    this.managerId,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      used: json['used'],
      sId: json['_id'],
      code: json['code'],
      managerId: json['managerId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['used'] = used;
    data['_id'] = sId;
    data['code'] = code;
    data['managerId'] = managerId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
