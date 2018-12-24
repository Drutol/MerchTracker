import 'package:flutter/material.dart';
import 'package:merch_tracker/dataLoader.dart';
import 'package:merch_tracker/models/merchItem.dart';
import 'package:merch_tracker/models/trackedSitesEnum.dart';
import 'package:merch_tracker/views/merchWidget.dart';

class SurugayaPage extends StatefulWidget {
  DataLoader _dataLoader = DataLoader(TrackedSite.Surugaya);
  List<MerchItem> _merchItems = List();

  @override
  _SurugayaPageState createState() => _SurugayaPageState();
}

class _SurugayaPageState extends State<SurugayaPage> {


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
        key: PageStorageKey<String>("SurugayaPage"),
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
