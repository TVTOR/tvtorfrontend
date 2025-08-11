import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';

//import 'package:dashed_container/dashed_container.dart';
//class Manager extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: ManagerPage(),
//    );
//  }
//}

class Manager extends StatefulWidget {
  Manager({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Manager> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/bg_white.png"))),
            child: Center(
                child: Stack(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: null),
                Column(
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
                      Container(
                        padding: EdgeInsets.only(top: 40),
                        child: ListTile(
                          title: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              'Sign Up',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.indigo[900],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(20.0),
                          subtitle: Text(
                            'As Tutor',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
//                          Padding( padding: EdgeInsets.only(top: 10,),),

                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: TextField(
//            controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'First Name',
                          ),
                        ),
                      ),
//                          Padding( padding: EdgeInsets.only(top: 10,),),

                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: TextField(
                          obscureText: true,
//            controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Last Name',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: TextField(
                          obscureText: true,
//            controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email id',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: TextField(
                          obscureText: true,
//            controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: TextField(
                          obscureText: true,
//            controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Confirm Password',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Text(
                          "Enter your given code",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                          left: 20,
                        ),
                        width: 320,
                        height: 60,
                        child: container1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          height: 60,
                          width: 500,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              textStyle: TextStyle(
                                  color:
                                      Colors.white), // Background coloext color
                            ),
                            child: const Text(
                              'SIGN IN',
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                      ),
                    ]),
              ],
            ))),
      )),
    );
  }

  Widget get container1 {
    return DottedBorder(
      options: RectDottedBorderOptions(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        dashPattern: [9, 5],
      ),
      child: Container(
//        height: 50,
        child: TextField(
          obscureText: true,
//            controller: passwordController,
          decoration: InputDecoration(
            labelText: 'Code',
          ),
        ),
        width: double.maxFinite,
        decoration: BoxDecoration(),
      ),
    );
  }
}
