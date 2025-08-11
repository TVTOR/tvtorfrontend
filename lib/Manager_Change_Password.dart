import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertvtor/Invite_Tutor.dart';
import 'package:fluttertvtor/SignIn.dart';
import 'package:fluttertvtor/Tutor_Assign.dart';
import 'package:fluttertvtor/Tutor_Manager_Home.dart';
import 'package:fluttertvtor/Tutor_Manager_Profile.dart';
import 'package:fluttertvtor/customdrawer.dart';
import 'package:fluttertvtor/models/requests/changepasswordrequest.dart';
import 'package:fluttertvtor/models/response/logoutresponse.dart';
import 'package:fluttertvtor/rest/network_util.dart';
import 'package:fluttertvtor/utils/CommonUtils.dart';
import 'package:fluttertvtor/utils/SharedPrefHelper.dart';
import 'package:easy_localization/easy_localization.dart';

//class ManagerChangePassword extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//
//      home: ChangePasswordPage(),
//    );
//  }
//
//}
class ManagerChangePassword extends StatefulWidget {
  ManagerChangePassword({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ManagerChangePassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
            key: _scaffoldKey,
            // drawer: CustomDrawer() ,
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
//                                  IconButton(
////                                  icon: new Image.asset('assets/menu_draw.png', color: Colors.indigo[900] ),
////                                        color: Colors.indigo,
////                                  icon:  Icon(Icons.menu,color: Colors.indigo[900]),
//                                    icon: new Image.asset('assets/menu_draw.png', color: Colors.indigo[900] ),
//                                    iconSize: 30,
//                                    onPressed: () => _scaffoldKey.currentState.openDrawer(),
//
////                                  ),
//                                  Padding( padding: EdgeInsets.only(left: 70,),
//                                      child:  Text("Change Password",
//                                        style: TextStyle(color:Colors.indigo[900], fontSize: 18,fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
//                                  )
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
                                  style: TextStyle(color: Colors.grey),
                                  controller: oldPasswordController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: tr('Form.Old_Password'),
                                  ),
                                  validator: (val) {
                                    if (val == null || val.isEmpty)
                                      return tr('Form.Empty');
                                    return null;
                                  }),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: TextFormField(
                                  obscureText: true,
                                  style: TextStyle(color: Colors.grey),
                                  controller: newPasswordController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: tr('Form.New_Password'),
                                  ),
                                  validator: (val) {
                                    if (val == null || val.isEmpty)
                                      return tr('Form.Empty');
                                    else if (val == oldPasswordController.text)
                                      return tr(
                                          'Form.Password_should_not_same');
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
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                height: 60,
                                width: 500,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    // Text color
                                    backgroundColor: Colors.lightBlue,
                                    // Button background color
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    submit();
                                  },
                                  child: Text(
                                    'SAVE'.tr(),
                                  ),
                                )),
                          ]),
                    )))));
  }

  Widget get container1 {
    return DottedBorder(
      options: RectDottedBorderOptions(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        dashPattern: [9, 5],
      ),
      child: Row(
//        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
//        height: 50,
//        Icon(Icons.person,
//            color: Colors.black),
//        TextField(
//          obscureText: true,
////            controller: passwordController,
//          decoration: InputDecoration(
//            labelText: 'Invite',
//          ),
//        ),
          children: <Widget>[
            Icon(Icons.share, color: Colors.black),
            Text(
              " Invite", style: TextStyle(color: Colors.black, fontSize: 20),

//            controller: passwordController,
            ).tr(),
          ]
//        width: double.maxFinite,
//        decoration: BoxDecoration(
//
//        ),

          ),
    );
  }

  submit() async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      CommonUtils.fullScreenProgress(context: context);
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
        );
      } else {
        CommonUtils.dismissProgressDialog(context);

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('old ${response.message ?? ''}'),
              );
            });
      }
    }
  }
}
