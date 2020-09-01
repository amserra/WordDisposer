import 'package:WordDisposer/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../extensions/string_extension.dart';

class WordList extends StatelessWidget {
  WordList(this.order);

  final String order;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Text("loading");
            } else {
              final prefs = snapshot.data;
              final List<String> keys = prefs.getKeys().toList(growable: false);
              if (order == "name") keys.sort();
              return ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: keys.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 15),
                  itemBuilder: (BuildContext context, int index) {
                    return buildItem(prefs, keys, index);
                  });
            }
          }),
    ));
  }

  Container buildItem(prefs, List<String> keys, int index) {
    return Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 2,
              color: kPrimaryColor.withOpacity(0.23),
            ),
          ],
        ),
        height: 50,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text('${keys[index].toString().capitalize()}',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w300,
                        color: kTextColor)),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                    '${prefs.getString(keys[index]).toString().capitalize()}',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w300,
                        color: kTextColor)),
              )
            ]));
  }
}
