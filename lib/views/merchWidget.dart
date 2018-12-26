import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart';
import 'package:merch_tracker/models/merchItem.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:merch_tracker/models/yahooMerchItem.dart';
import 'package:intl/intl.dart';

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
        _buildImageSection(),
        Expanded(
            child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildTypeSection(),
              buildTitle(),
              _buildPrice()
            ],
          ),
        ))
      ],
    ));
  }

  Expanded _buildImageSection() {
    return Expanded(
        flex: 0,
        child: Container(
          alignment: Alignment.topCenter,
          color: Color(0xFFf1f1f1),
          child: _buildImage(),
        ));
  }

  Expanded buildTitle() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Center(
          child: Text(_item.name),
        ),
      ),
      flex: 1,
    );
  }

  _buildImage() {
    return Container(
        decoration: BoxDecoration(
            color: Color(0xFFf6f6f6),
            boxShadow: [BoxShadow(color: Colors.black, blurRadius: .1)]),
        child: TransitionToImage(
          AdvancedNetworkImage(_item.imageUrl),
          loadingWidget: const CircularProgressIndicator(strokeWidth: 1),
          fit: BoxFit.contain,
          placeholder: const Icon(Icons.refresh),
          width: 120,
        ));
  }

  _buildPrice() {
    YahooMerchItem yahooItem;
    var endsIn = "";
    if (_item is YahooMerchItem) {
      yahooItem = _item as YahooMerchItem;

      var diff = yahooItem.finishDate.difference(DateTime.now());
      endsIn = diff.toString();
      var pos = endsIn.lastIndexOf('.');
      endsIn = endsIn.substring(0,pos);
    }

    return Expanded(
        flex: 0,
        child: IntrinsicHeight(
          child: Stack(children: [
            Container(
                alignment: Alignment.centerRight,
                child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.blue,
                          blurRadius: 2,
                          offset: Offset(.7, .7))
                    ]),
                    child: Column(
                      children: <Widget>[
                        Text("¥${_item.price}", style: TextStyle(fontSize: 18)),
                        Visibility(
                          visible: yahooItem != null,
                          child: Text("¥${yahooItem?.buyoutPrice}",
                              style: TextStyle(
                                  fontSize: 15, fontStyle: FontStyle.italic)),
                        )
                      ],
                    ))),
            Visibility(
              visible: yahooItem != null,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                    "Bids: ${yahooItem?.bidsCount}, Ends in: $endsIn",
                    style:
                        TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
              ),
            )
          ]),
        ));
  }

  _buildTypeSection() {
    if (_item.type == null) return Container(height: 0);

    return Expanded(
      child: Container(
          alignment: Alignment.topLeft,
          child: Text(
            _item.type,
            style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
          )),
      flex: 0,
    );
  }
}
