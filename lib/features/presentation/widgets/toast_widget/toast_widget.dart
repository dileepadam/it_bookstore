import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../utils/enums.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ToastUtils {
  static Timer? toastTimer;

  static void showCustomToast(
      BuildContext context, String message, ToastStatus status) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: getprimaryColor(status, context),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

String getTitle(ToastStatus toastStatus, BuildContext context) {
  switch (toastStatus) {
    case ToastStatus.SUCCESS:
      return "Success";
    case ToastStatus.ERROR:
      return "Error";
    case ToastStatus.FAIL:
      return "Fail";
  }
}

Color getprimaryColor(ToastStatus toastStatus, BuildContext context) {
  switch (toastStatus) {
    case ToastStatus.SUCCESS:
      // return colors(context).positiveColor50!;
      return Colors.lightBlueAccent;
    case ToastStatus.ERROR:
      // return colors(context).negativeColor50!;
      return Colors.lightBlueAccent;
    case ToastStatus.FAIL:
      // return colors(context).negativeColor50!;
      return Colors.lightBlueAccent;
  }
}

Widget getIcon(ToastStatus toastStatus, BuildContext context) {
  switch (toastStatus) {
    case ToastStatus.SUCCESS:
      return ToastIcon(
          icon: PhosphorIcons.check(PhosphorIconsStyle.bold),
          color: Colors.lightBlueAccent,
          context: context,
          toastStatus: toastStatus);
    case ToastStatus.FAIL:
      return ToastIcon(
          icon: PhosphorIcons.warning(PhosphorIconsStyle.bold),
          color: Colors.lightBlueAccent,
          context: context,
          toastStatus: toastStatus);
    case ToastStatus.ERROR:
      return ToastIcon(
          icon: PhosphorIcons.warning(PhosphorIconsStyle.bold),
          color: Colors.lightBlueAccent,
          context: context,
          toastStatus: toastStatus);
  }
}

Widget ToastIcon({
  required PhosphorIconData icon,
  required Color color,
  required BuildContext context,
  required ToastStatus toastStatus,
}) {
  return Center(
    child: Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      padding: EdgeInsets.all(8.18),
      child: Center(
          child: PhosphorIcon(
        icon,
        color: toastStatus == ToastStatus.ERROR
            ? Colors.black87
            : Colors.white,
        size: 19.64,
      )),
    ),
  );
}
