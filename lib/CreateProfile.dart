import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertvtor/hexColor.dart';
import 'package:fluttertvtor/models/requests/userrequest.dart';
import 'package:fluttertvtor/models/response/SubjectResponse.dart';
import 'package:fluttertvtor/rest/RestApiClient.dart';
import 'package:fluttertvtor/rest/network_util.dart';
import 'package:fluttertvtor/utils/CommonUtils.dart';
import 'package:fluttertvtor/utils/SharedPrefHelper.dart';
import 'package:fluttertvtor/Tutor_Profile.dart';

import 'models/response/userresponse.dart';

class CreateTutorProfile extends StatefulWidget {
  const CreateTutorProfile({
    Key? key,
    required this.title,
    required this.selectedList,
  }) : super(key: key);

  final UserRequest title;
  final List<String> selectedList;

  @override
  _CreateTutorProfileState createState() => _CreateTutorProfileState();
}

class _CreateTutorProfileState extends State<CreateTutorProfile> {
  late final UserRequest request;
  late final List<String>? selectedList;
  SubjectResponse? subBody;
  String? subject;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    request = widget.title;
    selectedList = widget.selectedList;
    getSubjectData();
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  List<SubjectItem> dataList = <SubjectItem>[];

  StreamController<List<SubjectItem>> streamController =
      StreamController.broadcast();

  getSubjectData() async {
    RestApiCalls rest = RestApiCalls();
    rest.getSubjectList().then((value) async {
      subBody = value;
      List<SubjectItem> dataList = subBody?.data?.data ?? [];
      if (selectedList != null) {
        for (var element in dataList) {
          for (var selected in selectedList!) {
            if (selected == element.sId) {
              element.isSelected = true;
            }
          }
        }
      }
      streamController.sink.add(dataList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop("Update");
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop("Update");
            },
          ),
          title: Text(tr("Choose_Your_Subjects"),
              style: TextStyle(fontSize: 20, color: Colors.black)),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      child: StreamBuilder<List<SubjectItem>>(
                          stream: streamController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return gridView(snapshot.data ?? []);
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          // Text color
                          backgroundColor: Colors.blue,
                          // Button background color
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: saveSubjects,
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

  gridView(List<SubjectItem> data) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3.0,
      crossAxisSpacing: 20.0,
      mainAxisSpacing: 30,
      controller: new ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: data.map((value) {
        return GestureDetector(
          onTap: () {
            dataList.forEach((element) {
              if (element.sId == value.sId) {
                if (dataList
                        .where((element) => element.isSelected == true)
                        .toList()
                        .length <
                    3) {
                  element.isSelected = !(element.isSelected == true);
                } else {
                  element.isSelected = false;
                }
              }
            });
            streamController.sink.add(dataList);
          },
          child: Card(
              elevation: 4,
              color: value.isSelected == true
                  ? HexColor(CustomColor.lightThemeBlueColor)
                  : Colors.white,
              child: DottedBorder(
                  options: RectDottedBorderOptions(
                    color: Colors.blue,
                    strokeWidth: 1,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(
                            value.subject ?? '',
                            style: TextStyle(
                                color: value.isSelected == true
                                    ? Colors.white
                                    : Colors.black),
                          )),
                      Padding(
                          padding: EdgeInsets.only(left: 10, top: 5),
                          child: Image.asset(
                            "assets/tick_ion.png",
                          )),
                    ],
                  ))),
        );
      }).toList(),
    );
  }

  Future<void> saveSubjects() async {
    List<SubjectItem> selectedList =
        dataList.where((element) => element.isSelected == true).toList();

    List<String> list = <String>[];

    selectedList.forEach((element) {
      list.add(element.sId ?? '');
    });

    request.subjects = list.join(",");

    if (list.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr("Please_select_at_least_one_subject")),
          duration: const Duration(milliseconds: 1000),
          elevation: 2,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      print(jsonEncode(request));

      CommonUtils.fullScreenProgress(context: context);

      FormData formData = new FormData.fromMap(jsonDecode(jsonEncode(request)));
      String token = await SharedPrefHelper()
          .getWithDefault(SharedPrefHelper.token, "null");
      String id = await SharedPrefHelper().getWithDefault("id", "null");
      var res = await NetworkUtil().putApi(NetworkUtil.BASE_URL + "user/$id",
          token: token, isFormData: true, body: formData);
      UserResponse response = UserResponse.fromJson(res);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(tr("Profile_Update_Successfully")),
          duration: Duration(milliseconds: 500),
          behavior: SnackBarBehavior.floating,
        ));

        CommonUtils.dismissProgressDialog(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Tutor_Profile()));
      } else {
        CommonUtils.showToast(msg: response.message ?? '');
        CommonUtils.dismissProgressDialog(context);
      }
    }
  }
}
