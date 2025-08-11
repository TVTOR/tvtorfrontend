class ForgetPasswordResponse {
  bool? success;
  String? message;
  int? statusCode;

  ForgetPasswordResponse({
    this.success,
    this.message,
    this.statusCode,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponse(
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
