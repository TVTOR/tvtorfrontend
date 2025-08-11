class RegisterRequest {
  String? name;
  String? surname;
  String? email;
  String? password;
  List<String>? subjects;
  List<String>? location;
  String? mobileNumber;
  String? managerId;
  String? userType;
  String? code;

  RegisterRequest({
    this.name,
    this.surname,
    this.email,
    this.password,
    this.subjects,
    this.location,
    this.mobileNumber,
    this.managerId,
    this.userType,
    this.code,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      name: json['name'] ,
      surname: json['surname'] ,
      email: json['email'],
      password: json['password'] ,
      subjects: json['subjects'] != null
          ? List<String>.from(json['subjects'])
          : null,
      location: json['location'] != null
          ? List<String>.from(json['location'])
          : null,
      mobileNumber: json['mobileNumber'] ,
      managerId: json['managerId'] ,
      userType: json['userType'] ,
      code: json['code'] ,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surname;
    data['email'] = email;
    data['password'] = password;
    data['subjects'] = subjects;
    data['location'] = location;
    data['mobileNumber'] = mobileNumber;
    data['managerId'] = managerId;
    data['userType'] = userType;
    data['code'] = code;
    return data;
  }
}

