import 'dart:async';
import 'dart:io';
import 'dart:math';

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
import 'package:fluttertvtor/models/response/BaseResponse.dart';
import 'package:fluttertvtor/models/response/TutorsResponse.dart';
import 'package:fluttertvtor/models/response/userresponse.dart';
import 'package:fluttertvtor/mvp/TutorsContract.dart';
import 'package:fluttertvtor/rest/RestApiClient.dart';
import 'package:fluttertvtor/utils/CommonUtils.dart';
import 'package:fluttertvtor/models/response/userresponse.dart' as user;
import 'package:fluttertvtor/utils/TransparentPageRoute.dart';
import 'package:fluttertvtor/utils/custom_views/CommonStrings.dart';
import 'package:fluttertvtor/utils/pushnotification.dart';
import 'package:easy_localization/easy_localization.dart';

class TutorManagerHome extends StatefulWidget {
  TutorManagerHome({Key? key, this.title, this.name}) : super(key: key);

  final String? title;
  String? name;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TutorManagerHome> with TutorsContract {
  TextEditingController commentController = TextEditingController();

  File? image;
  File? _image;
  late TutorsPresenter tPresenter;
  StreamController<List<TutorsItem>> _controller = StreamController.broadcast();
  StreamController _Image = StreamController();

  final GlobalKey<RefreshIndicatorState> refreshIndicator = GlobalKey();
  late PushNotificationsManager pushNotificationsManager;

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  void initState()  {
    super.initState();
    tPresenter = new TutorsPresenter(this);
  pushNotificationsManager = PushNotificationsManager(context);
    pushNotificationsManager.init();
    getTutors();
  }

  ImageModal? imageModal;
  List<TutorsItem> tutorList = <TutorsItem>[];
  List<Widget> listWidget = <Widget>[];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        top: true,
        child: Scaffold(
          drawer: CustomDrawer(),
          backgroundColor: Colors.white,
          body: RefreshIndicator(
            key: refreshIndicator,
            onRefresh: onRefresh,
            child: Container(
              child: StreamBuilder<List<TutorsItem>>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final tutorList = snapshot.data ?? [];
                      if (tutorList.isEmpty) {
                        return Center(
                          child: Text(
                            tr("No_Tutor_associated_yet"),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        );
                      } else {
                        final dataList = snapshot.data ?? [];
                        return StaggeredGrid.count(
                          crossAxisCount: 3,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          children: dataList
                              .map((item) => StaggeredGridTile.fit(
                                    crossAxisCellCount: 1,
                                    child: childList(item),
                                  ))
                              .toList(),
                        );
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
        ));
  }

  @override
  void onTutorsError(String error) {
    CommonUtils.showToast(msg: error);
  }

  @override
  void onTutorsSuccess(TutorsResponse mData) {
    //  print("Madhur ${mData.data.data[0].subjectData[0].colorcode}");
    if (mData.status == true) {
      final dataList = mData.data?.data ?? [];
      listWidget.clear();
      listWidget.addAll(dataList.map((value) => childList(value)));
      if (dataList.length == listWidget.length) {
        _controller.sink.add(dataList);
      }
      /*if (mData.data.data.length == listWidget.length)
        _controller.sink.add(mData.data.data);*/
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

  deleteTutor(String id) async {
    RestApiCalls api = RestApiCalls();
    BaseResponse res = await api.deleteUsers(id).catchError((e) {
      return false;
    });
    if (res.statusCode == 200) {
      CommonUtils.showToast(msg: res.message ?? "");
      return true;
    } else {
      return false;
    }
    return false;
  }

  Widget childList(TutorsItem value) {
    print("value.id is ${value.sId}");
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        GestureDetector(
          onLongPress: () {
            tutorList.forEach((element) {
              if (element.sId == value.sId) {
                element.isShowDelete = true;
              } else {
                element.isShowDelete = false;
              }
              _controller.sink.add(tutorList);
            });
          },
          onTap: () async {
            String comment = await showDialog(
                context: context,
                builder: (buildContext) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(10),
                    content: TutorInfoDialog(
                      data: value,
                      comment: value.comment ?? "",
                    ),
                  );
                });
            if (comment != null && comment.isNotEmpty) {
              tutorList.forEach((element) {
                if (element.sId == value.sId) {
                  element.comment = comment;
                  print("Found");
                }
              });
              _controller.sink.add(tutorList);
            }
          },
          child: Container(
            decoration: value.isShowDelete == true
                ? BoxDecoration(
                    color: Colors.black26,
                    border: Border.all(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)))
                : BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
            margin: new EdgeInsets.all(2.0),
            child: new Center(
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
                      fit: BoxFit.cover,
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
                      final colorCode = e.colorcode ?? '#000000';
                      final sId = e.sId ?? 'unknown';
                      print("colors are $colorCode");
                      print("sId is $sId");

                      final subjectText = e.subject ?? '';

                      return Card(
                        color: HexColor(colorCode),
                        margin: const EdgeInsets.all(2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 12.0, left: 12.0, top: 1, bottom: 1),
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
                  ),
                ),
                Padding(
                  padding:
                      new EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                  child: Container(
                      height: 30,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                        (value.comment == null || value.comment!.isEmpty)
                            ? tr("Add_Comment")
                            : value.comment!,
                      )),
                ),
              ],
            )),
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (buildContext) {
                  return AlertDialog(
                    title: Text(tr("Alert")),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          CommonUtils.fullScreenProgress(context: context);

                          final bool success =
                              await deleteTutor(value.sId ?? "");

                          CommonUtils.dismissProgressDialog(context);

                          if (success) {
                            tutorList.remove(value);
                            _controller.sink.add(tutorList);
                          } else {
                            // Optionally handle failure here, e.g., show a message
                          }
                        },
                        child: Text(
                          tr("Yes"),
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          tutorList.forEach((element) {
                            if (element.sId == value.sId) {
                              element.isShowDelete = false;
                            }
                          });
                          _controller.sink.add(tutorList);
                        },
                        child: Text(
                          tr("No"),
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    content: Text(tr("Are_you_sure_want_to_delete")),
                  );
                });
          },
          child: Visibility(
            visible: value.isShowDelete == true ? true : false,
            child: CircleAvatar(
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> onRefresh() async {
    await tPresenter.getTutors();
  }
}
//print("id is ${}");
