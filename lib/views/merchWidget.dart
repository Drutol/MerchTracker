import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart';
import 'package:merch_tracker/models/merchItem.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';
import 'package:merch_tracker/models/yahooMerchItem.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
        child: InkWell(
      onTap: () => _onTapped(),
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
      ),
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
      child: CachedNetworkImage(
        imageUrl: _item.imageUrl,
        placeholder: Container(
          child: Center(child: const CircularProgressIndicator(strokeWidth: 1)),
          width: 120,
        ),
        errorWidget: Container(width: 120, child: Center(child: Icon(Icons.cancel))),
        fit: BoxFit.contain,
        width: 120,
      ),
    );
  }

  _buildPrice() {
    YahooMerchItem yahooItem;
    var endsIn = "";
    if (_item is YahooMerchItem) {
      yahooItem = _item as YahooMerchItem;

      var diff = yahooItem.finishDate
          .difference(DateTime.now().add(Duration(hours: 8)));

      int days = diff.inSeconds ~/ 86400;
      int remainder = diff.inSeconds - days * 86400;
      int hours = remainder ~/ 3600;
      remainder = remainder - hours * 3600;
      int mins = remainder ~/ 60;

      if (days > 0) endsIn = "${days}d ";

      if (hours > 0) endsIn += "${hours}h ";

      if (mins > 0) endsIn += "${mins}m";
    }

    var style = TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Colors.blueAccent);

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
                          visible:
                              yahooItem != null && yahooItem.buyoutPrice != 0,
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
                  child: RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                        TextSpan(
                            text: "Bids: "),
                        TextSpan(
                          text: "${yahooItem?.bidsCount},",
                          style: style, 
                        ),
                        TextSpan(
                          text: " Ends in: ",
                        ),
                        TextSpan(
                          text: "$endsIn",
                          style: style
                        )
                      ]))),
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

  _onTapped() {
    if (_item.link?.isNotEmpty ?? false) launch(_item.link);
  }
}
