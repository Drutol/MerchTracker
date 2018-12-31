import 'package:merch_tracker/interfaces/siteCrawler.dart';
import 'package:merch_tracker/models/merchItem.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class MandarakeCrawler implements SiteCrawler {
  static const String _endpoint =
      "https://order.mandarake.co.jp/order/listPage/list?keyword=蒼の彼方のフォーリズム";

  @override
  Future<List<MerchItem>> getMerch() async {
    var html = await http.get(_endpoint);
    var document = parse(html.body);

    var blocks = document
        .getElementsByClassName("thumlarge")
        .first
        .getElementsByClassName("block");
    var output = new List<MerchItem>();
    for (var block in blocks) {
      try {
        var item = MerchItem(
            name: block.getElementsByClassName("title").first.text.trim(),
            imageUrl: block.querySelector("img").attributes["src"],
            link: "https://order.mandarake.co.jp" +
                block.querySelector("a").attributes["href"],
            price: (int.parse(block
                        .getElementsByClassName("price")
                        .first
                        .text
                        .replaceAll(",", "")
                        .replaceAll("円+税",
                            "") //wanted regex but dart's regex seem to be broken
                        .trim()) *
                    1.08)
                .round());
        if (item.imageUrl.contains("r18.png"))
          item.imageUrl = block
              .getElementsByClassName("r18item")
              .first
              .querySelector("img")
              .attributes["src"];

        output.add(item);
      } catch (e) {
        continue;
      }
    }

    return output;
  }
}
