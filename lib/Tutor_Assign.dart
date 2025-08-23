import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertvtor/models/tutorHistory/TutorHistoryNotification.dart';
import 'package:fluttertvtor/mvp/TutorHistoryMvp.dart';
import 'package:fluttertvtor/slelect_tutor_screen.dart';
import 'package:fluttertvtor/utils/CommonUtils.dart';
import 'package:easy_localization/easy_localization.dart';

class Tutor_Assign extends StatefulWidget {
  Tutor_Assign({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Tutor_Assign> with TutorHistoryContract {
  List<String> inputs = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    presenter = TutorHistoryPresenter(this);
    presenter.doTutorHistory();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    // You need to dispose each StreamController when screen destroyed
    streamController.close();
  }

  late TutorHistoryPresenter presenter;

  StreamController<List<Data>> streamController = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<Data>>(
            stream: streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if ((snapshot.data?.length ?? 0) == 0) {
                  return Center(
                    child: Text(tr("No_request_available")),
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final dataList = snapshot.data ?? [];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (buildContext) => SelectTutorScreen(
                                      nId: snapshot.data?[index].id ?? "",
                                    ),),);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: ClipPath(
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            color: Colors.blue, width: 5))),
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          _listItemTitle(dataList[index]),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              _listItemSubtitle(index),
                                              _listItemTime(dataList[index])
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        );
                      });
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Widget _listItemTitle(Data data) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, top: 20),
        child: Text(
          tr("Received_new_request_for") +
              " " +
              (data.subject ?? []).join(",") +
              " " +
              " at " +
              " " +
              (data.location ?? []).join(","),
          style: const TextStyle(fontWeight: FontWeight.w600),
          maxLines: 3,
        ));
  }

  Widget _listItemSubtitle(int index) {
    //  String msg = tr('Please_assign_a_Tutor');
    return Padding(
      padding: EdgeInsets.only(left: 10.0, top: 10),
//        child: const Text.rich(
//          TextSpan(
//              text: msg,
//              style: TextStyle(
//                  color: Colors.blue,
//                  fontWeight: FontWeight.w600,
//                  decoration: TextDecoration.underline) // default text style
//
//              ),
//        )
      child: Text(tr('Please_assign_a_Tutor'),
          style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline) // default text style

          ),
    );
  }

  Widget _listItemTime(Data data) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20),
      child: Builder(
        builder: (context) {
          String timeString;
          try {
            final dateTime =
                data.createdAt != null ? DateTime.parse(data.createdAt!) : null;
            timeString = dateTime != null
                ? CommonUtils.getTimeIn24HoursDate(dateTime)
                : tr('Invalid_time');
          } catch (e) {
            timeString = tr('Invalid_time');
          }

          return Text(
            '${tr('Time')} $timeString',
            textAlign: TextAlign.end,
            softWrap: false,
            overflow: TextOverflow.fade,
          );
        },
      ),
    );
  }

  @override
  void onTutorHistoryError(String error) {
    //CommonUtils.showToast(msg: ApiConstants.serverErrorMsg);
    print("Error " + error);
  }

  @override
  void onTutorHistorySuccess(TutorHistoryNotification user) {
    if (user.statusCode == 200) {
      final userDataList = user.data ?? [];

      for (var i in userDataList) {
        final createdAt = i.createdAt ?? 'Unknown date';
        print("user data is $createdAt");
      }

      streamController.sink.add(userDataList);
    }
  }
}
