import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertvtor/Invite_Tutor.dart';
import 'package:fluttertvtor/Manager_Change_Password.dart';
import 'package:fluttertvtor/SignIn.dart';
import 'package:fluttertvtor/TutorInfoDialog.dart';
import 'package:fluttertvtor/Tutor_Assign.dart';
import 'package:fluttertvtor/Tutor_Manager_Profile.dart';
import 'package:fluttertvtor/customdrawer.dart';
import 'package:fluttertvtor/hexColor.dart';
import 'package:fluttertvtor/models/imagemodal.dart';
import 'package:fluttertvtor/models/requests/AssignTutorRequest.dart';
import 'package:fluttertvtor/models/response/BaseResponse.dart';
import 'package:fluttertvtor/models/response/TutorsResponse.dart';
import 'package:fluttertvtor/mvp/TutorsContract.dart';
import 'package:fluttertvtor/rest/RestApiClient.dart';
import 'package:fluttertvtor/rest/apiConfig.dart';
import 'package:fluttertvtor/utils/CommonUtils.dart';
import 'package:fluttertvtor/utils/custom_views/CommonStrings.dart';

import 'mvp/AssignTutorMvp.dart';

class SelectTutorScreen extends StatefulWidget {
  final String nId;

  const SelectTutorScreen({Key? key, required this.nId}) : super(key: key);

  @override
  SelectTutorScreenState createState() => SelectTutorScreenState();
}

class SelectTutorScreenState extends State<SelectTutorScreen>
    with TutorsContract, AssignTutorContract {
  TextEditingController commentController = TextEditingController();
  late TutorsPresenter tPresenter;
  late AssignTutorPresenter assignPresenter;
  late final String nId;
  StreamController<List<TutorsItem>> _controller = StreamController.broadcast();
  StreamController<bool> isButtonShowController = StreamController.broadcast();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.close();
    isButtonShowController.close();
  }

  @override
  void initState() {
    super.initState();
    tPresenter = new TutorsPresenter(this);
    assignPresenter = new AssignTutorPresenter(this);
    nId = widget.nId;
    getTutors();
  }

  ImageModal? imageModal;
  List<TutorsItem> tutorList = <TutorsItem>[];
  List<Widget> listWidget = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Scaffold(
          appBar: AppBar(
            title:
                Text(tr("Assign_tutor"), style: TextStyle(color: Colors.black)),
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          drawer: CustomDrawer(),
          backgroundColor: Colors.white,
          body: new Container(
            padding: EdgeInsets.all(10),
            child: StreamBuilder<List<TutorsItem>>(
                stream: _controller.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    tutorList = snapshot.data ?? [];
                    if ((snapshot.data?.length ?? 0) == 0) {
                      return Center(
                        child: Text(
                          tr("No_Tutor_associated_yet"),
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      );
                    } else {
                      return Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(bottom: 40.0),
                              child: MasonryGridView.count(
                                itemCount: snapshot.data?.length,
                                crossAxisCount: 3,
                                //  crossAxisSpacing: 1.0,
                                // childAspectRatio: 0.6,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                // children: listWidget,
                                itemBuilder: (BuildContext context, int index) {
                                  final dataList = snapshot.data ??
                                      []; // fallback to empty list if null
                                  return childList(dataList[index]);
                                },
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 4.0,
                              )),
                          Positioned(
                            bottom: 0,
                            child: StreamBuilder<bool>(
                                stream: isButtonShowController.stream,
                                initialData: false,
                                builder: (context, snapshot) {
                                  return Visibility(
                                    visible: snapshot.data ?? false,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: ButtonTheme(
                                        minWidth:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height: 40,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: HexColor(
                                                CustomColor
                                                    .lightThemeBlueColor),
                                            foregroundColor: Colors.white,
                                            // text color
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onPressed: () {
                                            late final String tId;
                                            tutorList.forEach((element) {
                                              if (element.isShowDelete ==
                                                  true) {
                                                tId = element.sId ?? "";
                                              }
                                            });
                                            AssignTutorRequest request =
                                                AssignTutorRequest(
                                                    notificationId: nId,
                                                    tutorId: tId);
                                            assignTutor(request);
                                          },
                                          child: Text(
                                            tr("Assign_tutor"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      );
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ));
  }

  @override
  void onTutorsError(String error) {
    CommonUtils.showToast(msg: error);
  }

  @override
  void onTutorsSuccess(TutorsResponse mData) {
    print("Madhur");
    if (mData.status == true) {
      final dataList = mData.data?.data ?? [];
      if (dataList.isNotEmpty) {
        listWidget.clear();

        for (var value in dataList) {
          listWidget.add(childList(value));
        }
      }

      if (dataList.length == listWidget.length) {
        _controller.sink.add(dataList);
      }
    } else {
      if (mData.message == "Unauthenticated.") {
        print("Session has been expird! Please login again.");
      } else {
        CommonUtils.showAlertDialog(
            context, CommonStrings.alert, mData.message ?? "");
      }
    }
  }

  Future<void> getTutors() async {
    CommonUtils.isNetworkAvailable().then((bool connected) {
      if (connected) {
        /*CommonUtils.fullScreenProgress(context: context);*/
        tPresenter.getTutors();
      } else {
        // Internet is not connected
      }
    });
  }

  assignTutor(AssignTutorRequest request) async {
    CommonUtils.fullScreenProgress(context: context);
    assignPresenter.doAssignTutor(jsonEncode(request));
  }

  @override
  void onAssignTutorError(String error) {
    CommonUtils.dismissProgressDialog(context);
    //CommonUtils.showToast(msg: ApiConstants.serverErrorMsg);
  }

  @override
  void onAssignTutorSuccess(BaseResponse response) {
    CommonUtils.dismissProgressDialog(context);
    if (response.statusCode == 200) {
      CommonUtils.showToast(msg: response.message ?? "");
      Navigator.pop(context);
    } else {
      CommonUtils.showToast(msg: response.message ?? "");
    }
  }

  Widget childList(TutorsItem value) {
    print("value.id is ${value.sId}");
    return GestureDetector(
      onTap: () {
        isButtonShowController.sink.add(true);
        tutorList.forEach((element) {
          if (element.sId == value.sId) {
            element.isShowDelete = true;
          } else {
            element.isShowDelete = false;
          }
          _controller.sink.add(tutorList);
        });
      },
      child: Container(
        decoration: value.isShowDelete == true
            ? BoxDecoration(
                color: Colors.black26,
                border: Border.all(
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)))
            : BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: new EdgeInsets.all(2.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(padding: new EdgeInsets.all(0.5)),
                Container(
                  height: 100,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: (value.imageUrl != null && value.imageUrl!.isNotEmpty)
                          ? NetworkImage(value.imageUrl!)
                          : AssetImage("assets/add_photo.png") as ImageProvider,
                      fit: BoxFit.cover, // optional, to control image sizing
                    ),
                    border:
                        Border.all(width: 1.0, color: const Color(0xFF00B8D4)),
                  ),
                ),
                Text(
                  value.name ?? "",
                  style: new TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView(
                    shrinkWrap: true,
                    children: (value.subjectData ?? []).map((e) {
                      final colorCode = (e.colorcode != null && e.colorcode!.isNotEmpty) ? e.colorcode! : '#000000'; // fallback color if null
                      final subjectText = e.subject ?? '';         // fallback text if null

                      return Card(
                        color: HexColor(colorCode),
                        margin: const EdgeInsets.all(2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
                          child: Text(
                            subjectText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ),
                Padding(
                  padding:
                      new EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                  child: Container(
                      height: 30,
                      width: 100,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        // controller: commentController,
                        initialValue:
                            value.comment != null ? value.comment : "Comment",
                        readOnly: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(fontSize: 11),
                            hintText: tr('Comment')),
                      )),
                ),
              ],
            )),
            Center(
              child: Visibility(
                visible: value.isShowDelete == true ? true : false,
                child: CircleAvatar(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
