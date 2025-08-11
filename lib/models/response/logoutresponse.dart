class LogoutResponse {
  bool? success;
  String? message;
  int? statusCode;

  LogoutResponse({this.success, this.message, this.statusCode});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      success: json['success'],
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['statusCode'] = statusCode;
    return data;
  }
}
