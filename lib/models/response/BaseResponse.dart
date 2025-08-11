class BaseResponse {
    String? message;
    int? statusCode;
    bool? success;

    BaseResponse({
        this.message,
        this.statusCode,
        this.success,
    });

    factory BaseResponse.fromJson(Map<String, dynamic> json) {
        return BaseResponse(
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
        return data;
    }
}
