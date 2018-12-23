import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart';
import 'package:merch_tracker/models/merchItem.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';

class MerchWidget extends StatefulWidget {
  MerchItem _item;

  MerchWidget(MerchItem item) {
    _item = item;
  }

  @override
  State<StatefulWidget> createState() {
    return _MerchWidgetState(_item);
  }
}

class _MerchWidgetState extends State<MerchWidget> {
  MerchItem _item;

  double _itemHeight = 150;

  _MerchWidgetState(MerchItem item) {
    _item = item;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFf6f6f6),
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: .1)
                      ]),
                  child: TransitionToImage(
                    AdvancedNetworkImage(_item.imageUrl),
                    loadingWidget: const CircularProgressIndicator(),
                    fit: BoxFit.contain,
                    placeholder: const Icon(Icons.refresh),
                    width: 120,
                  )),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(_item.type),
                    flex: 0,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(_item.name),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text(_item.price.toString()),
                    flex: 0,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
