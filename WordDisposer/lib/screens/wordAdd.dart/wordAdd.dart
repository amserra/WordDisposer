import 'package:WordDisposer/components/displayDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WordAdd extends StatefulWidget {
  @override
  _WordAddState createState() => _WordAddState();
}

class _WordAddState extends State<WordAdd> {
  String enWord = "";
  String ptWord = "";
  final TextEditingController _controller1 = new TextEditingController();
  final TextEditingController _controller2 = new TextEditingController();

  void handleEnChange(value) {
    setState(() {
      enWord = value;
    });
  }

  void handlePtChange(value) {
    setState(() {
      ptWord = value;
    });
  }

  Future<void> handleSubmit() async {
    if (enWord == "" || ptWord == "") {
      displayDialog(context, "Insert the two words.");
    } else {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(enWord, ptWord);
      displayDialog(context, "Word successfully added.");
      _controller1.clear();
      _controller2.clear();
      setState(() {
        enWord = "";
        ptWord = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Text(
              'English word',
              style: TextStyle(fontSize: 20),
            )),
        Container(
          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: CupertinoTextField(
            maxLines: 1,
            controller: _controller1,
            onChanged: (value) => handleEnChange(value),
          ),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Text(
              'Portuguese word',
              style: TextStyle(fontSize: 20),
            )),
        Container(
          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: CupertinoTextField(
            maxLines: 1,
            controller: _controller2,
            onChanged: (value) => handlePtChange(value),
          ),
        ),
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 50),
            child: CupertinoButton.filled(
              child: Text(
                "Add word",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => handleSubmit(),
            )),
      ],
    )));
  }
}
