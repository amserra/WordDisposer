import 'package:WordDisposer/constants.dart';
import 'package:WordDisposer/screens/wordAdd.dart/wordAdd.dart';
import 'package:WordDisposer/screens/wordList.dart/wordList.dart';
import 'package:WordDisposer/screens/wordSearch.dart/wordSearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
        fontFamily: 'NunitoSans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(body: MyHomePage(title: 'WordDisposal')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String order = "time";

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add),
            title: Text('Add'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.collections),
            title: Text('List'),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: WordAdd(),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: WordSearch(),
              );
            });
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildImage("icons/flags/png/us.png", 5.0, 0.0),
                      IconButton(
                          icon: order == "time"
                              ? Icon(Icons.access_time, color: Colors.grey)
                              : Icon(Icons.sort_by_alpha, color: Colors.grey),
                          onPressed: () => this.setState(() {
                                order = order == "time" ? "name" : "time";
                              })),
                      buildImage("icons/flags/png/pt.png", 0.0, 5.0),
                    ],
                  ),
                ),
                child: WordList(order),
              );
            });
            break;
        }
        return returnValue;
      },
    );
  }

  Container buildImage(String img, double l, double r) {
    return Container(
        padding: EdgeInsets.only(left: l, right: r),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: new Image.asset(
            img,
            package: 'country_icons',
            height: 35,
            width: 50,
          ),
        ));
  }
}
