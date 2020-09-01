import 'package:WordDisposer/apis/data_models/googleTranslate.dart';
import 'package:WordDisposer/apis/data_models/linguee.dart';
import 'package:WordDisposer/apis/fetch_functions/fetchGoogleTranslate.dart';
import 'package:WordDisposer/apis/fetch_functions/fetchLinguee.dart';
import 'package:WordDisposer/components/displayDialog.dart';
import 'package:WordDisposer/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../extensions/string_extension.dart';

class WordSearch extends StatefulWidget {
  @override
  _WordSearchState createState() => _WordSearchState();
}

class _WordSearchState extends State<WordSearch> {
  String _searchWord = "";

  Future<void> handleSubmit(String enWord, String ptWord) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(enWord, ptWord);
    displayDialog(context, "Word successfully added.");
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Column(
      children: [
        buildSearch(),
        FutureBuilder<Linguee>(
          future: fetchLinguee(_searchWord),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<String> results = lingueeResults(snapshot.data);
              return buildLingueeCard(screenW, results);
            } else if (snapshot.hasError) {
              if (snapshot.error.toString() == "Exception: empty query") {
                // Do nothing - normally first query
                return SizedBox();
              }
              // Else, show a "No results card"
              return buildLingueeCard(screenW, List<String>());
            }
            return Container(
                margin: EdgeInsets.only(top: 40),
                child: CupertinoActivityIndicator());
          },
        ),
        // FutureBuilder<GoogleTranslate>(
        //   future: fetchGoogleTranslate(_searchWord),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       final List<String> results =
        //           googleTranslateResults(snapshot.data);
        //       return buildLingueeCard(screenW, results);
        //     } else if (snapshot.hasError) {
        //       print(snapshot.error.toString());
        //       if (snapshot.error.toString() == "Exception: empty query") {
        //         // Do nothing - normally first query
        //         return SizedBox();
        //       }
        //       // Else, show a "No results card"
        //       return buildLingueeCard(screenW, List<String>());
        //     }
        //     return Container(
        //         margin: EdgeInsets.only(top: 40),
        //         child: CupertinoActivityIndicator());
        //   },
        // ),
      ],
    ));
  }

  Container buildLingueeCard(double screenW, List<String> results) {
    return Container(
      width: screenW,
      padding: EdgeInsets.all(kDefaultPadding),
      margin: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(5, 5),
            blurRadius: 5,
            color: kPrimaryColor.withOpacity(0.23),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset("assets/icons/lingueeLogo.svg",
                  height: 20, color: Colors.grey),
              results.isNotEmpty
                  ? FlatButton(
                      onPressed: () => handleSubmit(_searchWord, results[0]),
                      child: Icon(Icons.add),
                      shape: CircleBorder(),
                      color: kSecondaryColor,
                      textColor: Colors.white,
                    )
                  : SizedBox()
            ],
          ),
          SizedBox(height: 5),
          Text(results.isEmpty ? "No results" : results[0].capitalize(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold)),
          Text('${results.isNotEmpty ? results.sublist(1).join(", ") : ""}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.normal))
        ],
      ),
    );
  }

  Container buildSearch() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(kDefaultPadding, 40.0, kDefaultPadding, 0.0),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 2,
            color: kPrimaryColor.withOpacity(0.23),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              onSubmitted: (value) {
                setState(() {
                  _searchWord = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  color: kPrimaryColor.withOpacity(0.5),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.search, color: Colors.black54),
        ],
      ),
    );
  }
}
