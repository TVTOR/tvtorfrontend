import 'package:fluttertvtor/models/response/BaseResponse.dart';
import 'package:fluttertvtor/rest/RestApiClient.dart';

mixin AddCommentContract {
  void onAddCommentSuccess(BaseResponse response);

  void onAddCommentError(String error);
}

class AddCommentPresenter {
  AddCommentContract _view;
  RestApiCalls api = new RestApiCalls();

  AddCommentPresenter(this._view);

  doAddComment(var body) {
    api.addComment(body).then((BaseResponse user) {
      _view.onAddCommentSuccess(user);
    }).catchError((Object error) => _view.onAddCommentError(error.toString()));
  }
}
