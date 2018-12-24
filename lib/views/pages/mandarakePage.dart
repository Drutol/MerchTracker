
import 'package:flutter/material.dart';
import 'package:merch_tracker/dataLoader.dart';
import 'package:merch_tracker/models/merchItem.dart';
import 'package:merch_tracker/models/trackedSitesEnum.dart';
import 'package:merch_tracker/views/merchWidget.dart';

class MandarakePage extends StatefulWidget {
  DataLoader _dataLoader = DataLoader(TrackedSite.Mandarake);
  List<MerchItem> _merchItems = List();

  @override
  _MandarakePageState createState() => _MandarakePageState();
}

class _MandarakePageState extends State<MandarakePage> {

  @override
  void initState() {
    super.initState();
    if(widget._merchItems.length == 0)
      _refreshList();
  }

  @override
  bool get wantKeepAlive => true;

  Future _refreshList() async {
    var items = await widget._dataLoader.getMerch();
    setState(() {
      widget._merchItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        key: PageStorageKey<String>("MandarakePage"),
        onRefresh: _refreshList,
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: widget._merchItems.length,
          itemBuilder: (context, i) {
            if (i.isOdd) return Divider();
            final index = i ~/ 2;

            return MerchWidget(widget._merchItems[index]);
          },
        ));
  }
}