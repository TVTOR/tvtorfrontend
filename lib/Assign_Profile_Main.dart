import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Welcome John Smith"),
          backgroundColor: Colors.indigo[900],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: const [
              Tab(
                icon: Icon(Icons.group),
                text: "Assign",
              ),
              Tab(
                icon: Icon(Icons.person),
                text: "Profile",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("Assign Tab Content")),
            Center(child: Text("Profile Tab Content")),
            //TutorAssign(),
            // TutorProfile(),
          ],
        ),
      ),
    );
  }
}
