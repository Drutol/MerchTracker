import 'dart:convert';

import 'package:merch_tracker/models/merchItem.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'dart:convert' show utf8;
import '../interfaces/siteCrawler.dart';

class SurugayaCrawler implements SiteCrawler {
  static const String _endpoint =
      "https://www.suruga-ya.jp/search?category=10&search_word=蒼の彼方のフォーリズム&adult_s=1&rankBy=modificationTime%3Adescending";

  @override
  Future<List<MerchItem>> getMerch() async {
    var html = await http.get(_endpoint, headers: {"cookie": "adult=1"});

  
    var document = parse(utf8.decode(html.bodyBytes, allowMalformed: true));
    var items = document.getElementsByClassName("item");
    var output = new List<MerchItem>();

    for (var htmlItem in items) {
      output.add(MerchItem(
          name: htmlItem.getElementsByClassName("title").first.text,
          imageUrl: htmlItem.querySelector("img").attributes["src"],
          link: "https://www.suruga-ya.jp/" + htmlItem.querySelector("a").attributes["href"],
          type: htmlItem
              .getElementsByClassName("condition")
              .first
              .text
              .replaceAll("|", "")
              .trim(),
          price: int.parse(htmlItem
              .querySelector("strong")
              .text
              .replaceAll(new RegExp("￥|,"), "")
              .trim())));
    }
    return output;
  }
}
