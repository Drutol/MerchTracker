import 'package:flutter/material.dart';
import 'package:merch_tracker/dataLoader.dart';
import 'package:merch_tracker/models/trackedSitesEnum.dart';
import 'package:merch_tracker/models/yahooMerchItem.dart';
import 'package:merch_tracker/views/merchWidget.dart';

class YahooPage extends StatefulWidget {
  DataLoader _dataLoader = DataLoader(TrackedSite.Yahoo);
  List<YahooMerchItem> _merchItems = List();

  @override
  _YahooPageState createState() => _YahooPageState();
}

class _YahooPageState extends State<YahooPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);

    if (widget._merchItems.length == 0) _refreshList();
  }

  Future _refreshList() async {
    var items = await widget._dataLoader.getMerch();
    setState(() {
      widget._merchItems = items.cast<YahooMerchItem>().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        key: PageStorageKey<String>("YahooPage"),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                  color: Colors.blue,
                  child: TabBar(
                    indicatorColor: Colors.white,
                    controller: _controller,
                    tabs: <Widget>[
                      Tab(icon: Icon(Icons.panorama_horizontal)),
                      Tab(icon: Icon(Icons.favorite_border))
                    ],
                  ),
                ),
                flex: 0),
            Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    buildMerchList(widget._merchItems
                        .where((item) => item.kind == YahooItemKind.Tapestry).toList()),
                    buildMerchList(widget._merchItems
                        .where((item) => item.kind == YahooItemKind.Daki).toList())
                  ],
                ),
                flex: 1)
          ],
        ));
  }

  Widget buildMerchList(List<YahooMerchItem> merch) {
    return RefreshIndicator(
        onRefresh: _refreshList,
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: merch.length,
          itemBuilder: (context, i) {
            if (i.isOdd) return Divider();
            final index = i ~/ 2;

            return MerchWidget(merch[index]);
          },
        ));
  }
}
