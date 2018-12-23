import 'package:merch_tracker/businessLogic/typeItemFilter.dart';
import 'package:merch_tracker/crawlers/surugayaCrawler.dart';
import 'package:merch_tracker/interfaces/itemFilter.dart';
import 'package:merch_tracker/interfaces/siteCrawler.dart';
import 'package:merch_tracker/models/merchItem.dart';

class DataLoader {
  List<SiteCrawler> _crawlers = [new SurugayaCrawler()];
  List<ItemFilter> _filters = [new TypeItemFilter()];

  Future<List<MerchItem>> getMerch() async {
    var output = new List<MerchItem>();
    for (var crawler in _crawlers) {
      output.addAll((await crawler.getMerch()).where(
          (item) => _filters.every((filter) => !filter.isFiltered(item))));
    }
    return output;
  }
}
