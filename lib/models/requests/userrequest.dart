class UserRequest {
  final String? name;
  final String? surname;
  final String? description;
  final String? availability;
  final String? email;
  String? subjects;
  final String? location;
  final String? mobileNumber;

  UserRequest({
    this.name,
    this.surname,
    this.email,
    this.subjects,
    this.availability,
    this.description,
    this.mobileNumber,
    this.location,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) {
    return UserRequest(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      subjects: json['subjects'],
      availability: json['availability'],
      description: json['description'],
      mobileNumber: json['mobileNumber'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surname;
    data['email'] = email;
    data['description'] = description;
    data['availability'] = availability;
    data['subjects'] = subjects;
    data['location'] = location;
    data['mobileNumber'] = mobileNumber;
    return data;
  }
}

