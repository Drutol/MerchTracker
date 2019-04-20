import 'package:merch_tracker/models/merchItem.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import '../interfaces/siteCrawler.dart';

class MercariCrawler implements SiteCrawler {
  static const String _endpoint =
      "https://www.mercari.com/jp/search/?keyword=蒼の彼方　タペストリ";

  @override
  Future<List<MerchItem>> getMerch() async {
    var html = await http.get(_endpoint);

    var document = parse(html.body);
    var items = document.getElementsByClassName("items-box");
    var output = new List<MerchItem>();

    for (var htmlItem in items) {
      output.add(MerchItem(
          name: htmlItem.querySelector(".items-box-name.font-2").text,
          imageUrl: htmlItem.querySelector("img").attributes["data-src"],
          link: htmlItem.querySelector("a").attributes["href"],
          price: int.parse(htmlItem
              .querySelector(".items-box-price.font-5")
              .text
              .replaceAll(new RegExp("¥|,"), "").replaceAll(",", "")
              .trim())));
    }
    return output;
  }
}
