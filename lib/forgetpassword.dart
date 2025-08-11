import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertvtor/models/requests/forgetpasswordrequest.dart';
import 'package:fluttertvtor/models/response/forgetpasswordResponse.dart';
import 'package:fluttertvtor/rest/network_util.dart';
import 'package:fluttertvtor/utils/CommonUtils.dart';

import 'hexColor.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController userEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: SingleChildScrollView(
          primary: true,
          physics: ScrollPhysics(),
          child: Container(
//          decoration: BoxDecoration(
//              image: DecorationImage(
//                  fit: BoxFit.fitWidth,
//                  image: AssetImage("assets/header_img.png")
//              )
//          ),
            child: Column(
              //  mainAxisSize: MainAxisSize.max,
              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                      // color: Colors.green,
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage("assets/header_img.png"))),
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 30.0,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context)),
                  ),
                ),
                Container(
                  height: 100,
                  child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        tr('Forget_Password'),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 25,
                          color: HexColor("#122345"),
                          fontWeight: FontWeight.w700,
                        ),
                      ).tr(),
                    ),
                    contentPadding: const EdgeInsets.all(20.0),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: tr('Form.Email_id'),
                      ),
                      controller: userEmailController,
                      validator: (val) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = new RegExp(pattern);
                        if (val == null || val.isEmpty)
                          return tr('Form.Please_Enter_employee_Id');
                        else if (!regex.hasMatch(val))
                          return tr('Form.Enter_Valid_Email');
                        else
                          return null;
                      },
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          // Text color
                          backgroundColor: HexColor("#10acff"),
                          // Button background color
                          textStyle: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          submit(); // Call your submit function
                          //                              if(isTutor = true)
                          ////                              if( isTutor = true)
                          //                                    {
                          //                                  Navigator.push(
                          //                                      context,
                          //                                      MaterialPageRoute(builder: (context) =>
                          //                                          TutorSignUp())
                          //                                  );
                          //
                          //                                }else if(isTutor = false){
                          //                                Navigator.push(
                          //                                    context,
                          //                                    MaterialPageRoute(builder: (context) =>
                          //                                        TutorSignUp())
                          //                                );
                          //                              }

                          //  }

                          //                          onPressed: isTutor = true
                          //                              ? () =>
                          //                                                          Navigator.push(
                          //                                  context,
                          //                                  MaterialPageRoute(builder: (context) => Tutor_Profile())
                          //
                          // You can change the second page to something else if you want different navigation when isTutor == false
                        },
                        child: Text(tr('Send')),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      CommonUtils.fullScreenProgress(context: context);
      var res = await NetworkUtil().post(
          url: "forgotpassword",
          body: ForgetPasswordRequest(email: userEmailController.text));
      ForgetPasswordResponse response = ForgetPasswordResponse.fromJson(res);
      if (response.success == true) {
        print("res is $res");
        CommonUtils.dismissProgressDialog(context);
        CommonUtils.showToast(msg: response.message ?? "");
      } else {
        CommonUtils.dismissProgressDialog(context);
        CommonUtils.showToast(msg: response.message ?? "");
      }
    }
  }
}
