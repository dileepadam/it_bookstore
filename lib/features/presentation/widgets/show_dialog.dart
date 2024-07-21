import 'package:flutter/material.dart';

class ShowDialog {
  final BuildContext? context;
  final String? title;
  final String? descriptionOne;
  final String? descriptionTwo;
  final Widget? actionButtonOne;
  final Widget? actionButtonTow;

  ShowDialog(
      {this.context,
      this.title,
      this.descriptionOne,
      this.descriptionTwo,
      this.actionButtonOne,
      this.actionButtonTow}) {
    _showMyDialog();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title!),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(descriptionOne ?? ""),
              ],
            ),
          ),
          actions: <Widget>[
            actionButtonOne ??
                TextButton(
                  child: const Text(""),
                  onPressed: () {},
                ),
          ],
        );
      },
    );
  }
}
