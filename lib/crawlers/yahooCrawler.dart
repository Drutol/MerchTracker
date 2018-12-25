import 'package:merch_tracker/interfaces/siteCrawler.dart';
import 'package:merch_tracker/models/merchItem.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as Json;

import 'package:merch_tracker/models/yahooMerchItem.dart';

class YahooCrawler implements SiteCrawler {
  static const String _endpointTapestry =
      "https://www.fromjapan.co.jp/sites/yahooauction/search?exhibitType=0&condition=0&keyword=蒼の彼方　タペストリ&category=All&_=1545657263795";

  static const String _endpointDakis =
      "https://www.fromjapan.co.jp/sites/yahooauction/search?exhibitType=0&condition=0&keyword=蒼の彼方　抱き枕&category=All&_=1545657263795";

  @override
  Future<List<MerchItem>> getMerch() async {
    var output = new List<MerchItem>();

    var json = await http.get(_endpointDakis);
    output.addAll(parse(json.body, YahooItemKind.Daki));

    json = await http.get(_endpointTapestry);
    output.addAll(parse(json.body, YahooItemKind.Tapestry));

    return output;
  }

  List<YahooMerchItem> parse(String json, YahooItemKind kind) {
    var data = Autogenerated.fromJson(Json.jsonDecode(json));
    return data.items
        .map((item) => YahooMerchItem(
            name: item.title,
            price: item.price,
            imageUrl: item.imageUrl,
            bidsCount: item.bids,
            buyoutPrice: item.buyItNowPrice,
            finishDate: DateTime.parse(item.endTime.replaceAll("/", "")),
            kind: kind))
        .toList();
  }
}

class Autogenerated {
  int count;
  int hits;
  List<Items> items;

  Autogenerated({this.count, this.hits, this.items});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    hits = json['hits'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }
}

class Items {
  String id;
  String title;
  int price;
  String imageUrl;
  String url;
  int sale;
  int tax;
  int postage;
  String seller;
  String categoryId;
  int bids;
  String endTime;
  int buyItNowPrice;
  String condition;
  int exhibitType;
  bool isReserved;
  bool isNewArrival;
  bool isCheck;

  Items(
      {this.id,
      this.title,
      this.price,
      this.imageUrl,
      this.url,
      this.sale,
      this.tax,
      this.postage,
      this.seller,
      this.categoryId,
      this.bids,
      this.endTime,
      this.buyItNowPrice,
      this.condition,
      this.exhibitType,
      this.isReserved,
      this.isNewArrival,
      this.isCheck});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    url = json['url'];
    sale = json['sale'];
    tax = json['tax'];
    postage = json['postage'];
    seller = json['seller'];
    categoryId = json['categoryId'];
    bids = json['bids'];
    endTime = json['endTime'];
    buyItNowPrice = json['buyItNowPrice'];
    condition = json['condition'];
    exhibitType = json['exhibitType'];
    isReserved = json['isReserved'];
    isNewArrival = json['isNewArrival'];
    isCheck = json['isCheck'];
  }
}