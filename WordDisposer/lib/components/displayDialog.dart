import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void displayDialog(BuildContext context, String msg) {
  showDialog(
    context: context,
    builder: (BuildContext context) => new CupertinoAlertDialog(
      title: Text(msg),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            child: Text("Close"),
            onPressed: () => Navigator.pop(context))
      ],
    ),
  );
}
