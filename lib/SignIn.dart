import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertvtor/TutorSignUp.dart';
import 'package:fluttertvtor/Tutor_Manager_Profile.dart';
import 'package:fluttertvtor/Tutor_Profile.dart';
import 'package:fluttertvtor/commondrawer.dart';
import 'package:fluttertvtor/forgetpassword.dart';
import 'package:fluttertvtor/hexColor.dart';
import 'package:fluttertvtor/main.dart';
import 'package:fluttertvtor/models/requests/LoginRequest.dart';
import 'package:fluttertvtor/models/response/LoginResponse.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertvtor/models/response/RegisterResponse.dart' as rr;
import 'package:fluttertvtor/mvp/LoginScreenContract.dart';
import 'package:fluttertvtor/rest/apiConfig.dart';
import 'package:fluttertvtor/rest/network_util.dart';
import 'package:fluttertvtor/utils/CommonUtils.dart';
import 'package:fluttertvtor/utils/SharedPrefHelper.dart';
import 'package:fluttertvtor/utils/custom_views/CommonStrings.dart';
import 'package:fluttertvtor/utils/pushnotification.dart';

//class SignIn extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: TutorLoginPage(),
//    );
//  }
//}

class SignIn extends StatefulWidget {
//  final bool isTutor;
//  bool isTutor = true ;
  final bool? isTutor;
  String? name;
  String? surname;
  String? email;
  String? location;
  String? subjects;
  String? token;
  String? id;

  SignIn({
    Key? key,
    this.title,
    this.isTutor,
    this.subjects,
    this.location,
    this.token,
    this.name,
    this.id,
    this.surname,
    this.email,
  }) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignIn> with LoginContract {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userEmailController = new TextEditingController();
  TextEditingController userPasswordController = new TextEditingController();

  late LoginPresenter presenter;
  late LoginRequest request;
  bool? isTutor;
  int localeIndex = 1;

  @override
  void initState() {
    super.initState();
    isTutor = widget.isTutor;
    print(isTutor);
    presenter = LoginPresenter(this);
    request = LoginRequest();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/bg_white.png"))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          "assets/header_image.png",
                          fit: BoxFit.fill,
                          color: Colors.transparent,
                        ),
                      ),
//                      IconButton(
//                        onPressed: (){
//                          if(localeIndex == 1){
//                            context.locale = context.supportedLocales[localeIndex];
//                            localeIndex = 0 ;
//                          }else {
//                            context.locale = context.supportedLocales[localeIndex];
//                            localeIndex = 1;
//                          }
//                        },
//                        icon: Icon(Icons.add),
//                      ),
                      Container(
                        height: 100,
                        child: ListTile(
                          title: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              tr('Sign_In'),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 25,
                                color: HexColor("#122345"),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(20.0),
                          subtitle: Text(
                            tr('subtitle'),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                        ),
                      ),
                      Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: TextFormField(
//            controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: tr('Form.Email_id'),
                                ),
                                controller: userEmailController,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return tr('Form.Please_Enter_employee_Id');
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              child: TextFormField(
                                controller: userPasswordController,
                                obscureText: true,
//            controller: passwordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: tr('Form.Password'),
                                ),
                                validator: (val) {
//                            if (userPasswordController.text.length < 4) {
//                              return CommonStrings.validPassword;
//                            }
//                            else
                                  if (val == null || val.isEmpty) {
                                    return tr('Form.Required_Password');
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15, left: 200),
                              child: GestureDetector(
                                  child: Text(tr("Forget_Password"),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                      )),
                                  onTap: () {
                                    // do what you need to do when "Click here" gets clicked
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgetPassword()));
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child:
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,           // text color
                                    backgroundColor: HexColor("#10acff"),    // button background color
                                    textStyle: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  onPressed: () {
                                    submit();

                                    // // Assuming `isTutor` is a bool variable accessible here
                                    // if (isTutor == true) {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(builder: (context) => TutorSignUp()),
                                    //   );
                                    // } else {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(builder: (context) => TutorSignUp()),
                                    //   );
                                    //   // Change the above page to a different one if needed for isTutor == false
                                    // }
                                  },
                                  child: Text(tr('SIGN_IN')),
                                ),),
                            Container(
                                padding: EdgeInsets.only(top: 20, left: 20),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      tr("Don't_have_an_account"),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: Colors.grey),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 1),
                                        child: TextButton(
                                          child: Text(
                                            tr('SIGN_UP'),
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: HexColor("#10acff"),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyHomePage()));
//                                 bool isTutor = false;
//          bool isTutor = true ;
//               if(isTutor== true) {
//           Navigator.push(
//          context,
//                MaterialPageRoute(
//                        builder: (context) => Tutor_Profile()));
//             }
//               else if( isTutor = false){
//              Navigator.push(
//         context, MaterialPageRoute(
//             builder: (context) => ManagerProfilePage()));
//
//   }

//                                  if(isTutor==1) {
//                                    Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                            builder: (context) => TutorManagerProfile()));
//                                  }
//                                  else if{
//
//
//                                  }

                                            //signup screen
                                          },
                                        ))
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ))
                          ]))
                    ])),
          )),
    );
  }

  submit() {
    final form = _formKey.currentState;
    form!.save();
    if (form!.validate()) {
      request.email = userEmailController.text;
      request.password = userPasswordController.text;

//      request.name = userFirstNameController.text;
//      request.password = passwordController.text;
      CommonUtils.isNetworkAvailable().then((bool connected) async {
        if (connected) {
          CommonUtils.fullScreenProgress(context: context);
//          presenter.doLogin(jsonEncode(request));
          var res = await NetworkUtil().post(
              url: NetworkUtil.BASE_URL + ApiConfig.login,
              body: jsonEncode(request));
          LoginResponse response = LoginResponse.fromJson(res);
          if (response.success == true) {
            CommonUtils.dismissProgressDialog(context);
            bool token = await SharedPrefHelper()
                .save(SharedPrefHelper.token, response.data?.token);
            bool id = await SharedPrefHelper().save("id", response.data?.sId?? "");
            bool first = await SharedPrefHelper().save("first", true);
            print("token is $token \n id is ${response.data?.sId.toString()}");
            response.data?.userType == "tutormanager"
                ? isTutor = false
                : isTutor = true;
            await SharedPrefHelper().save("tutor", isTutor);
            if (isTutor == true) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Tutor_Profile()),
                  ModalRoute.withName("/"));
            } else if (isTutor == false) {
              final pushManager = PushNotificationsManager(context);
              pushManager.refreshAndSendFcmToken();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => CommonDrawer()),
                  ModalRoute.withName("/"));
            }
          } else {
            CommonUtils.dismissProgressDialog(context);
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(response.message ??''),
                  );
                });
          }
        } else {
          print("no internet");
          CommonUtils.showToast(msg: tr("No_Connection"));
        }
      });
    }
  }

  @override
  void onLoginError(String error) {
    CommonUtils.dismissProgressDialog(context);
    CommonUtils.showToast(msg: error);
    // TODO: implement onLoginError
  }

  @override
  void onLoginSuccess(LoginResponse response) async {
    String token =
        await SharedPrefHelper().getWithDefault(SharedPrefHelper.token, "null");

    String json = await SharedPrefHelper().getWithDefault(
        SharedPrefHelper.userData, rr.RegisterResponse().toString());

    rr.Data lData = rr.Data.fromJson(jsonDecode(json));

    if (userEmailController.text.isNotEmpty) {
      CommonUtils.isNetworkAvailable().then((bool connected)  async{
        if (connected) {
          LoginRequest lRequest = new LoginRequest();
          lRequest.email = lData.email;
          lRequest.password = lData.password;
          print("token has $token");
          if (isTutor == true) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Tutor_Profile()),
                ModalRoute.withName("/"));
          } else if (isTutor == false) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => CommonDrawer()),
                ModalRoute.withName("/"));
          }
        } else {
          CommonUtils.showToast(msg: tr("No_Connection"));
          print(" no internet");
        }
      });
    }
    // TODO: implement onLoginSuccess
  }
}
