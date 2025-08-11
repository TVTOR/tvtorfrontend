import 'package:flutter/material.dart';
import 'package:fluttertvtor/SignIn.dart';
import 'package:fluttertvtor/Tutor_Manager_Profile.dart';
import 'package:fluttertvtor/Tutor_Profile.dart';
import 'package:fluttertvtor/commondrawer.dart';
import 'package:fluttertvtor/demofile.dart';
import 'package:fluttertvtor/utils/SharedPrefHelper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    if (mounted) {
    call();
//      Future.delayed((Duration(seconds: 4))).then((value) {
//        Navigator.pushReplacement(
//            context, MaterialPageRoute(builder: (buildContext) => SignIn()));
//
//      });


//      }) : second ==  SharedPrefHelper().getWithDefault("tutor", null) ? Future.delayed((Duration(seconds: 4))).then((value) {
//        Navigator.pushReplacement(
//            context, MaterialPageRoute(builder: (buildContext) => Tutor_Profile()));
//      }): Future.delayed((Duration(seconds: 4))).then((value) {
//        Navigator.pushReplacement(
//            context, MaterialPageRoute(builder: (buildContext) => ManagerProfilePage()));
//      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Image.asset("assets/splash_logo.png"),
    );
  }

   call() async{
     bool b = await SharedPrefHelper().getWithDefault("first" , false);
     bool c = await SharedPrefHelper().getWithDefault("tutor", false);
     print(b);
     print(c);
     if(b){
       if(c){
         Future.delayed((Duration(seconds: 2))).then((value) {
           Navigator.pushReplacement(
               context, MaterialPageRoute(builder: (buildContext) => Tutor_Profile()));

         });
       }else{
         Future.delayed((Duration(seconds: 2))).then((value) {
           Navigator.pushReplacement(
               context, MaterialPageRoute(builder: (buildContext) => CommonDrawer()));

         });
       }
// Logged in navigate to home screen
     }

     else {

// Not Logged in
       Future.delayed((Duration(seconds: 4))).then((value) {
         Navigator.pushReplacement(
             context, MaterialPageRoute(builder: (buildContext) => SignIn()));

       });
     }
   }
}