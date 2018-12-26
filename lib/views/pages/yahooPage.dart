import 'package:flutter/material.dart';
import 'package:merch_tracker/models/trackedSitesEnum.dart';
import 'package:merch_tracker/models/yahooMerchItem.dart';
import 'package:merch_tracker/views/merchWidget.dart';
import 'package:merch_tracker/views/pages/base/merchPageState.dart';
import 'package:merch_tracker/views/pages/base/merchPageStatefulWidget.dart';
import 'package:merch_tracker/views/visiblityContainer.dart';

class YahooPage extends MerchPageStatefulWidget {
  YahooPage() : super(TrackedSite.Yahoo);

  @override
  _YahooPageState createState() => _YahooPageState();
}

class _YahooPageState extends MerchPageState<YahooPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        key: PageStorageKey<String>("YahooPage"),
        child: Stack(children: <Widget>[
          Column(
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
                      buildMerchList(widget.merchItems.cast<YahooMerchItem>()
                          .where((item) => item.kind == YahooItemKind.Tapestry)
                          .toList()),
                      buildMerchList(widget.merchItems.cast<YahooMerchItem>()
                          .where((item) => item.kind == YahooItemKind.Daki)
                          .toList())
                    ],
                  ),
                  flex: 1)
            ],
          ),
          Center(
              child: VisibilityContainer(
                  child: CircularProgressIndicator(),
                  isVisible: widget.isLoading))
        ]));
  }

  Widget buildMerchList(List<YahooMerchItem> merch) {
    return RefreshIndicator(
        onRefresh: refreshList,
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10),
          itemCount: merch.length * 2,
          itemBuilder: (context, i) {
            if (i.isOdd) return Divider();
            final index = i ~/ 2;

            return MerchWidget(merch[index]);
          },
        ));
  }
}
