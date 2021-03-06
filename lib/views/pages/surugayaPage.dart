import 'package:flutter/material.dart';
import 'package:merch_tracker/dataLoader.dart';
import 'package:merch_tracker/models/merchItem.dart';
import 'package:merch_tracker/models/trackedSitesEnum.dart';
import 'package:merch_tracker/views/merchWidget.dart';
import 'package:merch_tracker/views/pages/base/merchPageState.dart';
import 'package:merch_tracker/views/pages/base/merchPageStatefulWidget.dart';
import 'package:merch_tracker/views/visiblityContainer.dart';

class SurugayaPage extends MerchPageStatefulWidget {
  SurugayaPage() : super(TrackedSite.Surugaya);

  @override
  _SurugayaPageState createState() => _SurugayaPageState();
}

class _SurugayaPageState extends MerchPageState<SurugayaPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      RefreshIndicator(
          key: PageStorageKey<String>("SurugayaPage"),
          onRefresh: refreshList,
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            itemCount: widget.merchItems.length * 2,
            itemBuilder: (context, i) {
              if (i.isOdd) return Divider();
              final index = i ~/ 2;

              return MerchWidget(widget.merchItems[index]);
            },
          )),
      Center(
          child: VisibilityContainer(
              child: CircularProgressIndicator(), isVisible: widget.isLoading))
    ]);
  }
}
