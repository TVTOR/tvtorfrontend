import 'package:flutter/material.dart';

class TutorSignUp extends StatelessWidget {
  final bool? isTutor;
  
  const TutorSignUp({Key? key, this.isTutor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutor Sign Up'),
      ),
      body: Center(
        child: Text('Tutor Sign Up - ${isTutor == true ? "Tutor" : "Manager"}'),
      ),
    );
  }
}
