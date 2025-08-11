class AssignTutorRequest {
  String? notificationId;
  String? tutorId;

  AssignTutorRequest({required this.notificationId,required this.tutorId});

  factory AssignTutorRequest.fromJson(Map<String, dynamic> json) {
    return AssignTutorRequest(
      notificationId: json['notificationId'],
      tutorId: json['tutorId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notificationId'] = this.notificationId;
    data['tutorId'] = this.tutorId;
    return data;
  }
}
