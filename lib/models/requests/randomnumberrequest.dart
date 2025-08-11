class RandomNumberRequest {
  String? managerId;

  RandomNumberRequest({ this.managerId});

  factory RandomNumberRequest.fromJson(Map<String, dynamic> json) {
    return RandomNumberRequest(managerId: json['managerId']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['managerId'] = this.managerId;
    return data;
  }
}
