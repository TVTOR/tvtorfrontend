import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertvtor/Invite_Tutor.dart';
import 'package:fluttertvtor/SignIn.dart';
import 'package:fluttertvtor/Tutor_Assign.dart';
import 'package:fluttertvtor/Tutor_Manager_Home.dart';
import 'package:fluttertvtor/Tutor_Manager_Profile.dart';
import 'package:fluttertvtor/models/requests/changepasswordrequest.dart';
import 'package:fluttertvtor/models/response/logoutresponse.dart';
import 'package:fluttertvtor/rest/network_util.dart';
import 'package:fluttertvtor/utils/CommonUtils.dart';
import 'package:fluttertvtor/utils/SharedPrefHelper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';

class ManagerChangePassword extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangePasswordPage(),
    );
  }
}

class ChangePasswordPage extends StatefulWidget {
  final String? title;

  const ChangePasswordPage({Key? key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ChangePasswordPage> {
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
//            key: _scaffoldKey,

        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xFF122345),
                            ),
//                                        color: Colors.indigo,
                            iconSize: 30,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                left: 70,
                              ),
                              child: Text(
                                tr("Change_Password"),
                                style: TextStyle(
                                    color: Color(0xFF122345),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
//                          Padding( padding: EdgeInsets.only(top: 10,),),

                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: TextFormField(
                          obscureText: true,
                          controller: oldPasswordController,
                          style: TextStyle(color: Colors.grey),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: tr('Form.Old_Password'),
                          ),
                          validator: (String? val) {
                            if (val == null || val.isEmpty) {
                              return tr('Form.Empty');
                            }
                            return null;
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: TextFormField(
                          obscureText: true,
                          controller: newPasswordController,
                          style: TextStyle(color: Colors.grey),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: tr('Form.New_Password'),
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty)
                              return tr('Form.Empty');
                            if (val == oldPasswordController.text)
                              return tr('Form.Password_should_not_same');
                            return null;
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: TextFormField(
                          obscureText: true,
                          controller: confirmPasswordController,
                          style: TextStyle(color: Colors.grey),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: tr('Form.Confirm_Password'),
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty)
                              return tr('Form.Empty');
                            if (val != newPasswordController.text)
                              return tr('Form.Not_Match');
                            return null;
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                    ),

                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      height: 60,
                      width: 500,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          // text color
                          backgroundColor: Colors.lightBlue,
                          // button background color
                          textStyle: const TextStyle(fontSize: 20),
                          // You can also set padding, shape etc. here if needed
                        ),
                        onPressed: submit,
                        child: Text(tr('SAVE')),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  submit() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      String token = await SharedPrefHelper()
          .getWithDefault(SharedPrefHelper.token, "null");
      String id = await SharedPrefHelper().getWithDefault("id", "null");
      var res = await NetworkUtil().putApi("resetpassword/$id",
          body: ChangePasswordRequest(
              oldPassword: oldPasswordController.text,
              resetPassword: newPasswordController.text),
          token: token);
      LogoutResponse response = LogoutResponse.fromJson(res);
      if (response.success == true) {
        CommonUtils.dismissProgressDialog(context);
        bool token = await SharedPrefHelper().save(SharedPrefHelper.token, "");
        bool id = await SharedPrefHelper().save("id", "");
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => SignIn()),
//        );
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => SignIn()));
      } else {
        CommonUtils.dismissProgressDialog(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ChangePasswordPage()));
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(tr("old") + (response.message ?? '')),
              );
            });
      }
    }
  }
}
