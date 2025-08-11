import 'dart:io';
import 'dart:ui' as prefix1;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertvtor/models/imagemodal.dart';
import 'package:fluttertvtor/models/response/RegisterResponse.dart';
import 'package:intl/intl.dart';

import 'custom_views/CommonStrings.dart';

class CommonUtils extends InheritedWidget {
  static ImageModal? imageModal;

  static CommonUtils of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CommonUtils>()!;

  CommonUtils({Key? key, required Widget child}) : super(key: key, child: child);

  static Future<bool> isNetworkAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  static void showToast({required String msg}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 13.0,
    );
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static Widget fullScreenProgressWidget({
    required BuildContext context,
    required Color color,
  }) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          textViewWithOutClick(
            context,
            "",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ],
      ),
    );
  }

  static void fullScreenProgress({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black54,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              textViewWithOutClick(
                context,
                "",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget textViewWithOutClick(
      BuildContext context,
      String text, {
        double? fontSize,
        FontWeight? fontWeight,
        Color? color,
        TextAlign? textAlign,
        int maxLines = 2,
      }) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        decoration: TextDecoration.none,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  static void dismissProgressDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void showAlertDialog(
      BuildContext context, String title, String message) {
    Widget okButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [okButton],
    );

    showDialog(context: context, builder: (context) => alert);
  }

  static void showAlertDialogWithListener(
      BuildContext context,
      String title,
      String message, {
        required VoidCallback onOkClick,
      }) {
    Widget okButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
        onOkClick();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [okButton],
    );

    showDialog(context: context, builder: (context) => alert);
  }

  static String getTimeIn24HoursDate(DateTime dateTime) {
    final formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }
}
