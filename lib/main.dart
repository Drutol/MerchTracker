import 'package:flutter/material.dart';
import 'package:merch_tracker/dataLoader.dart';
import 'package:merch_tracker/models/merchItem.dart';
import 'package:merch_tracker/views/merchWidget.dart';

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
  int _counter = 0;

  DataLoader _dataLoader = DataLoader();
  List<MerchItem> _merchItems = List();

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  Future _refreshList() async {
    var items = await _dataLoader.getMerch();
    setState(() {
      _merchItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[_buildMerchList()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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

  Widget _buildMerchList() {
    return RefreshIndicator(
        onRefresh: _refreshList,
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: _merchItems.length,
          itemBuilder: (context, i) {
            if (i.isOdd) return Divider();
            final index = i ~/ 2;

            return MerchWidget(_merchItems[index]);
          },
        ));
  }
}
