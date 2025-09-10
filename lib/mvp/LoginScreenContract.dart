import 'package:fluttertvtor/models/response/LoginResponse.dart';
import 'package:fluttertvtor/rest/RestApiClient.dart';

mixin  LoginContract {
  void onLoginSuccess(LoginResponse user);

  void onLoginError(String error);
}

class LoginPresenter {
  LoginContract _view;
  RestApiCalls api = new RestApiCalls();

  LoginPresenter(this._view);

  doLogin(
      String body
      )
  {
    api.login(body).then((LoginResponse lData) {
      _view.onLoginSuccess(lData);
    }).catchError((Object error) => _view.onLoginError(error.toString()));
  }
}
