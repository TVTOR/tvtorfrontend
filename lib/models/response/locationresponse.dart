class LocationResponse {
  bool? success;
  Data? data;
  String? message;
  int? statusCode;

  LocationResponse({
    this.success,
    this.data,
    this.message,
    this.statusCode,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
      success: json['success'],
      data: json['data'] != null
          ? Data.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['message'] = message;
    data['statusCode'] = statusCode;
    return data;
  }
}

class Data {
  List<DataItem>? data;
  int? total;

  Data({
    this.data,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json['data'] != null
          ? List<DataItem>.from(
          (json['data'] as List).map((item) => DataItem.fromJson(item as Map<String, dynamic>)))
          : null,
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class DataItem {
  String? sId;
  String? location;
  String? createdAt;
  String? updatedAt;
  bool? isSelected;
  int? iV;

  DataItem({
    this.sId,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.isSelected,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      sId: json['_id'],
      location: json['location'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
      isSelected: json['isSelected'] != null ? json['isSelected'] : false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['location'] = location;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isSelected'] = isSelected;
    data['__v'] = iV;
    return data;
  }
}
