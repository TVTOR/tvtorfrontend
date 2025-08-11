import 'package:fluttertvtor/models/tutorHistory/TutorHistoryNotification.dart';
import 'package:fluttertvtor/rest/RestApiClient.dart';

mixin TutorHistoryContract {
  void onTutorHistorySuccess(TutorHistoryNotification user);

  void onTutorHistoryError(String error);
}

class TutorHistoryPresenter {
  TutorHistoryContract _view;
  RestApiCalls api = new RestApiCalls();

  TutorHistoryPresenter(this._view);

  doTutorHistory() {
    api.getNotifications().then((TutorHistoryNotification user) {
      _view.onTutorHistorySuccess(user);
    }).catchError(
        (Object error) => _view.onTutorHistoryError(error.toString()));
  }
}
