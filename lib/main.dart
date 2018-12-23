import 'package:flutter/material.dart';
import 'package:merch_tracker/dataLoader.dart';
import 'package:merch_tracker/models/merchItem.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:merch_tracker/views/merchWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  void _refreshList() async {
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
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshList,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildMerchList() {
    return ListView.builder(
      itemCount: _merchItems.length,
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;

        return MerchWidget(_merchItems[index]);
      },
    );
  }
}
