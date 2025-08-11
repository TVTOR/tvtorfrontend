
//import 'package:flutter_app/models/response/LoginResponse.dart';
//import 'package:flutter_app/rest/RestApiClient.dart';
import 'package:fluttertvtor/models/response/RegisterResponse.dart';
import 'package:fluttertvtor/rest/RestApiClient.dart';

mixin RegisterContract {
  void onRegisterSuccess(RegisterResponse user);

  void onRegisterError(String error);
}

class RegisterPresenter {
  RegisterContract _view;
  RestApiCalls api = new RestApiCalls();

  RegisterPresenter(this._view);

  doRegister(
      String body
      )
  {
    api.register(body).then((RegisterResponse user) {
      _view.onRegisterSuccess(user);
    }).catchError((Object error) => _view.onRegisterError(error.toString()));
  }
}
