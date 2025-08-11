import 'package:fluttertvtor/models/response/TutorsResponse.dart';
import 'package:fluttertvtor/rest/RestApiClient.dart';

mixin TutorsContract {
  void onTutorsSuccess(TutorsResponse mData);

  void onTutorsError(String error);
}

class TutorsPresenter {
  TutorsContract _view;
  RestApiCalls api = new RestApiCalls();

  TutorsPresenter(this._view);

  getTutors() async {
    TutorsResponse res = await api
        .getTutors()
        .catchError((Object error) => _view.onTutorsError(error.toString()));

    _view.onTutorsSuccess(res);
  }
}
