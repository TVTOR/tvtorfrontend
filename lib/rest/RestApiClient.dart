import 'package:fluttertvtor/models/response/BaseResponse.dart';
import 'package:fluttertvtor/models/response/LoginResponse.dart';
import 'package:fluttertvtor/models/response/RegisterResponse.dart';
import 'package:fluttertvtor/models/response/SubjectResponse.dart';
import 'package:fluttertvtor/models/response/TutorsResponse.dart';
import 'package:fluttertvtor/models/tutorHistory/TutorHistoryNotification.dart';
import 'package:fluttertvtor/rest/apiConfig.dart';
import 'package:fluttertvtor/rest/network_util.dart';
import 'package:fluttertvtor/utils/SharedPrefHelper.dart';

class RestApiCalls {
  NetworkUtil netUtil = new NetworkUtil();

  Future<LoginResponse> login(String body) {
    return netUtil.post(url: ApiConfig.login, body: body).then((dynamic res) {
      return LoginResponse.fromJson(res);
    });
  }

  Future<RegisterResponse> register(String body) {
    return netUtil
        .post(url: ApiConfig.register, body: body)
        .then((dynamic res) {
      return RegisterResponse.fromJson(res);
    });
  }

  Future<BaseResponse> deleteUsers(String id) async {
    String token =
        await SharedPrefHelper().getWithDefault(SharedPrefHelper.token, null);
    return netUtil
        .deleteApi(ApiConfig.user + id, token: token)
        .then((dynamic res) {
      return BaseResponse.fromJson(res);
    });
  }

  Future<BaseResponse> assignTutor(var body) async {
    String token =
        await SharedPrefHelper().getWithDefault(SharedPrefHelper.token, null);
    return netUtil
        .post(url: ApiConfig.assignTutor, token: token, body: body)
        .then((dynamic res) {
      return BaseResponse.fromJson(res);
    });
  }

  Future<TutorsResponse> getTutors() async {
    String token =
        await SharedPrefHelper().getWithDefault(SharedPrefHelper.token, null);

    String managerId =
        await SharedPrefHelper().getWithDefault(SharedPrefHelper.managerId, "");

    return netUtil
        .get(ApiConfig.tutors + managerId, token: token)
        .then((dynamic res) {
      return TutorsResponse.fromJson(res);
    });
  }

  Future<TutorHistoryNotification> getNotifications() async {
    String token =
        await SharedPrefHelper().getWithDefault(SharedPrefHelper.token, null);

    String managerId =
        await SharedPrefHelper().getWithDefault(SharedPrefHelper.managerId, "");

    return netUtil
        .get(ApiConfig.getNotification + managerId, token: token)
        .then((dynamic res) {
      return TutorHistoryNotification.fromJson(res);
    });
  }

  Future<SubjectResponse> getSubjectList() {
    return netUtil.get(ApiConfig.getSubject).then((dynamic res) {
      return SubjectResponse.fromJson(res);
    });
  }

  Future<BaseResponse> addComment(String body) async {
    String token =
        await SharedPrefHelper().getWithDefault(SharedPrefHelper.token, null);

    return netUtil
        .post(url: ApiConfig.addComment, token: token, body: body)
        .then((dynamic res) {
      return BaseResponse.fromJson(res);
    });
  }
}
