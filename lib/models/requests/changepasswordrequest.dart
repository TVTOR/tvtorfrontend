class ChangePasswordRequest {
  String? oldPassword;
  String? resetPassword;

  ChangePasswordRequest(
      {this.oldPassword,this.resetPassword});

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    return ChangePasswordRequest(
        oldPassword: json['oldPassword'], resetPassword: json['resetPassword']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oldPassword'] = this.oldPassword;
    data['resetPassword'] = this.resetPassword;
    return data;
  }
}
