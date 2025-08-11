class AddCommentRequest {
    String? comment;
    String? managerId;
    String? tutorId;

    AddCommentRequest({this.comment,  this.managerId,  this.tutorId});

    factory AddCommentRequest.fromJson(Map<String, dynamic> json) {
        return AddCommentRequest(
            comment: json['comment'], 
            managerId: json['managerId'], 
            tutorId: json['tutorId'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['comment'] = this.comment;
        data['managerId'] = this.managerId;
        data['tutorId'] = this.tutorId;
        return data;
    }
}