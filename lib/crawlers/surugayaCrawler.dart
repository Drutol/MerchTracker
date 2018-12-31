import 'package:merch_tracker/models/merchItem.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import '../interfaces/siteCrawler.dart';

class SurugayaCrawler implements SiteCrawler {
  static const String _endpoint =
      "https://www.suruga-ya.jp/search?category=10&search_word=蒼の彼方のフォーリズム&adult_s=1&rankBy=modificationTime%3Adescending";

  @override
  Future<List<MerchItem>> getMerch() async {
    var html = await http.get(_endpoint, headers: {"cookie": "adult=1"});

    var document = parse(html.body);
    var items = document.getElementsByClassName("item");
    var output = new List<MerchItem>();

    for (var htmlItem in items) {
      output.add(MerchItem(
          name: htmlItem.getElementsByClassName("title").first.text,
          imageUrl: htmlItem.querySelector("img").attributes["src"],
          link: htmlItem.querySelector("a").attributes["href"],
          type: htmlItem
              .getElementsByClassName("condition")
              .first
              .nodes[1]
              .text
              .replaceAll("|", "")
              .trim(),
          price: int.parse(htmlItem
              .getElementsByClassName("price")
              .first
              .firstChild
              .text
              .replaceAll(new RegExp("￥|,"), "")
              .trim())));
    }
    return output;
  }
}
