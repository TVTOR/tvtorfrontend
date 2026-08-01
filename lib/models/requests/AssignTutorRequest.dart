class AssignTutorRequest {
  String? notificationId;
  // Legacy single-tutor field, kept for backward compatibility.
  String? tutorId;
  // New: up to 3 tutor ids to assign in one call.
  List<String>? tutorIds;

  AssignTutorRequest({
    required this.notificationId,
    this.tutorId,
    this.tutorIds,
  });

  factory AssignTutorRequest.fromJson(Map<String, dynamic> json) {
    return AssignTutorRequest(
      notificationId: json['notificationId'],
      tutorId: json['tutorId'],
      tutorIds: (json['tutorIds'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notificationId'] = this.notificationId;
    if (this.tutorIds != null && this.tutorIds!.isNotEmpty) {
      data['tutorIds'] = this.tutorIds;
    } else if (this.tutorId != null) {
      data['tutorId'] = this.tutorId;
    }
    return data;
  }
}
