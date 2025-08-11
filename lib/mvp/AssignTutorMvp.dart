import 'package:fluttertvtor/models/response/BaseResponse.dart';
import 'package:fluttertvtor/rest/RestApiClient.dart';

mixin AssignTutorContract {
  void onAssignTutorSuccess(BaseResponse response);

  void onAssignTutorError(String error);
}

class AssignTutorPresenter {
  AssignTutorContract _view;
  RestApiCalls api = new RestApiCalls();

  AssignTutorPresenter(this._view);

  doAssignTutor(var body) {
    api.assignTutor(body).then((BaseResponse user) {
      _view.onAssignTutorSuccess(user);
    }).catchError((Object error) => _view.onAssignTutorError(error.toString()));
  }
}
