class NotificationRequest {
  String? tmId;
  String? deviceId;
  String? deviceType;
  String? deviceToken;

  NotificationRequest(
      { this.tmId,
       this.deviceId,
       this.deviceType,
       this.deviceToken});

  factory NotificationRequest.fromJson(Map<String, dynamic> json) {
    return NotificationRequest(
      tmId: json['tmId'],
      deviceId: json['deviceId'],
      deviceType: json['deviceType'],
      deviceToken: json['deviceToken'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tmId'] = this.tmId;
    data['deviceId'] = this.deviceId;
    data['deviceType'] = this.deviceType;
    data['deviceToken'] = this.deviceToken;
    return data;
  }
}
