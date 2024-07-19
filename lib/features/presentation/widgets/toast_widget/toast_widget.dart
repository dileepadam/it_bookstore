import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../utils/enums.dart';
import 'toast_animation.dart';

/*
* Usage:
*ToastUtils.showCustomToast(context,"Your text.");
* */
class ToastUtils {
  static Timer? toastTimer;

  static void showCustomToast(
      BuildContext context, String message, ToastStatus status) {
    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 56,
        left: 20,
        right: 20,
        child: SlideInToastMessageAnimation(IntrinsicHeight(
          child: Material(
            borderRadius: BorderRadius.circular(8),
            elevation: 0.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: getprimaryColor(status, context),
                boxShadow: [],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        getIcon(status, context),
                        12.horizontalSpace,
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(getTitle(status, context),
                                    style: size16weight700.copyWith(
                                        color: colors(context).blackColor)),
                                Text(
                                  message,
                                  style: size14weight400.copyWith(
                                      color: colors(context).greyColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    /// Two seconds later, remove Toast
    Future.delayed(const Duration(seconds: 4)).then((value) {
      overlayEntry.remove();
    });
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
      return colors(context).positiveColor50!;
    case ToastStatus.ERROR:
      return colors(context).negativeColor50!;
    case ToastStatus.FAIL:
      return colors(context).negativeColor50!;
  }
}

Widget getIcon(ToastStatus toastStatus, BuildContext context) {
  switch (toastStatus) {
    case ToastStatus.SUCCESS:
      return ToastIcon(
          icon: PhosphorIcons.check(PhosphorIconsStyle.bold),
          color: colors(context).positiveColor!,
          context: context,
          toastStatus: toastStatus);
    case ToastStatus.FAIL:
      return ToastIcon(
          icon: PhosphorIcons.warning(PhosphorIconsStyle.bold),
          color: colors(context).negativeColor!,
          context: context,
          toastStatus: toastStatus);
    case ToastStatus.ERROR:
      return ToastIcon(
          icon: PhosphorIcons.warning(PhosphorIconsStyle.bold),
          color: colors(context).negativeColor!,
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
            ? colors(context).blackColor
            : colors(context).whiteColor,
        size: 19.64,
      )),
    ),
  );
}
