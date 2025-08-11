import 'package:flutter/material.dart';
import 'package:fluttertvtor/Invite_Tutor.dart';
import 'package:fluttertvtor/Manager_Change_Password.dart';
import 'package:fluttertvtor/SignIn.dart';
import 'package:fluttertvtor/Tutor_Manager_Profile.dart';


class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class DemoFile extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Fragment 1", Icons.rss_feed),
    new DrawerItem("Fragment 2", Icons.local_pizza),
    new DrawerItem("Fragment 3", Icons.info)
  ];
  @override
  _DemoFileState createState() => _DemoFileState();
}

class _DemoFileState extends State<DemoFile> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
//    switch (pos) {
//      case 0:
//        return new TutorManagerProfile();
//      case 1:
//        return new InviteTutor();
//      case 2:
//        return MaterialPageRoute(builder: (context) => SignIn()) ;
//
//      default:
//        return new Text("Error");
//    }
  if(pos == 0){
   return TutorManagerProfile();
  }else if(pos == 1){
   return InviteTutor();
  }else if (pos == 2){
   Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignIn()));
  }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var drawerOptions;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: new Image.asset('assets/menu_draw.png', color: Colors.indigo[900] ),
//                                            icon:  Icon(Icons.menu,color: Colors.indigo[900]),
//                                        color: Colors.indigo,
          iconSize: 30,
          onPressed: () {
            _scaffoldKey
                .currentState!
                .openDrawer();
            // _Image.sink.add(imageModal);
          },
        ),
        title: Text(
          "Profile",
          style: TextStyle(
              color: Color(0xFF122345),
              fontSize: 18,
              fontWeight:
              FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("John Doe"), accountEmail: null),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),

    );
  }

}
