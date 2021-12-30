import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlert(
  BuildContext context, {
  required String msg,
  required String title,
  bool? logout,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content: Text(msg),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    },
  );
}
