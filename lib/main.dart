import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertvtor/TutorSignUp.dart';
import 'package:fluttertvtor/hexColor.dart';
import 'package:fluttertvtor/splashscreen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [Locale('en', 'US'), Locale('it', 'IT')],
    path: 'resources/langs',
    startLocale: Locale('it', 'IT'),
    // assetLoader: CodegenLoader()
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(fontFamily: "Rajdhani"),
        home: SplashScreen());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title, this.isTutor}) : super(key: key);

  final String? title;
  final bool? isTutor;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final bool? isTutor;

  Color _iconColor = Colors.grey;
  Color _iconColor2 = Colors.grey;
  Color borderColor = Colors.grey;
  Color borderColor2 = Colors.grey;
  bool pressTutor = false;
  bool pressManager = false;

  int? selectedUser; // 0 means Tutor and 1 means Tutor manager
  
  @override
  void initState() {
    isTutor = widget.isTutor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/bg_white.png"))),
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset("assets/header_img.png",
                  color: Colors.transparent),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Text(tr("Sign_Up"),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: HexColor("#122345"),
                                    fontSize: 25))),
                        Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(tr("Choose_Your_Self"),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 17))),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                    top: 20,
                  )),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                      ),
                      MaterialButton(
                        minWidth: 110.0,
                        height: 250.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(60.0),
                          side: BorderSide(
                              color: selectedUser == null
                                  ? Colors.grey
                                  : selectedUser == 0
                                      ? Colors.blue
                                      : Colors.grey,
                              width: 2),
                        ),
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 49,
                              child: Image.asset('assets/tutor.png'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            Text(
                              tr("Tutor"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                            ),
                            Icon(
                              Icons.check_circle,
                              color: selectedUser == null
                                  ? Colors.grey
                                  : selectedUser == 0
                                      ? Colors.blue
                                      : Colors.grey,
                              size: 40.0,
                            ),
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            selectedUser = 0;
                          });

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TutorSignUp(isTutor: true)));
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 20,
                          left: 20,
                        ),
                      ),
                      MaterialButton(
                        minWidth: 110.0,
                        height: 250.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(60.0),
                          side: BorderSide(
                              color: selectedUser == null
                                  ? Colors.grey
                                  : selectedUser == 1
                                      ? Colors.blue
                                      : Colors.grey,
                              width: 2),
                        ),
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 49,
                              child: Image.asset('assets/tutor.png'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            Text(
                              tr("Tutor_Manager"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                            ),
                            Icon(
                              Icons.check_circle,
                              color: selectedUser == null
                                  ? Colors.grey
                                  : selectedUser == 1
                                      ? Colors.blue
                                      : Colors.grey,
                              size: 40.0,
                            )
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TutorSignUp(isTutor: false)));
                          print(selectedUser);
                          setState(() {
                            selectedUser = 1;
                          });
                        },
                      ),
                    ],
                  )),
                  Padding(
                      padding: EdgeInsets.only(
                    bottom: 40,
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}