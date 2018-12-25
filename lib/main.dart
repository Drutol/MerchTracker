import 'package:flutter/material.dart';
import 'package:merch_tracker/models/trackedSitesEnum.dart';
import 'package:merch_tracker/views/pages/mandarakePage.dart';
import 'package:merch_tracker/views/pages/surugayaPage.dart';
import 'package:merch_tracker/views/pages/yahooPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MerchTracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Merch Tracker'),
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
  var _currentPage;

  set currentPage(TrackedSite site) {
    _currentPage = site;
    _currentPageWidget = _pages[site];
  }

  var _currentPageWidget;
  var _pages = {
    TrackedSite.Surugaya: SurugayaPage(),
    TrackedSite.Mandarake: MandarakePage(),
    TrackedSite.Yahoo: YahooPage(),
  };

  @override
  void initState() {
    currentPage = TrackedSite.Surugaya;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[_currentPageWidget],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage.index,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.looks_one), title: Text("Suruga-ya")),
          BottomNavigationBarItem(
              icon: Icon(Icons.looks_two), title: Text("Mandarake")),
          BottomNavigationBarItem(
              icon: Icon(Icons.looks_3), title: Text("Yahoo"))
        ],
      ),
    );
  }

  void _onTabTapped(int value) {
    setState(() {
      currentPage = TrackedSite.values[value];
    });
  }
}
