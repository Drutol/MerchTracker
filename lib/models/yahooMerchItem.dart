import 'package:merch_tracker/models/merchItem.dart';

enum YahooItemKind { Daki, Tapestry }

class YahooMerchItem extends MerchItem {
  DateTime finishDate;
  int buyoutPrice;
  int bidsCount;
  YahooItemKind kind;

  YahooMerchItem(
      {this.finishDate,
      this.buyoutPrice,
      this.bidsCount,
      this.kind,
      String name,
      int price,
      String imageUrl,
      String type}) {
    this.name = name;
    this.price = price;
    this.imageUrl = imageUrl;
    this.type = type;
  }
}
