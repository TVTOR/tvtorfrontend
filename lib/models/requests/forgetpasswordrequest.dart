class ForgetPasswordRequest {
  String? email;

  ForgetPasswordRequest({this.email});

  factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordRequest(email: json['email']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}