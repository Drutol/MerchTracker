import 'package:merch_tracker/businessLogic/typeItemFilter.dart';
import 'package:merch_tracker/crawlers/mandarakeCrawler.dart';
import 'package:merch_tracker/crawlers/mercariCrawler.dart';
import 'package:merch_tracker/crawlers/surugayaCrawler.dart';
import 'package:merch_tracker/crawlers/yahooCrawler.dart';
import 'package:merch_tracker/interfaces/itemFilter.dart';
import 'package:merch_tracker/interfaces/siteCrawler.dart';
import 'package:merch_tracker/models/merchItem.dart';
import 'package:merch_tracker/models/trackedSitesEnum.dart';

class DataLoader {
  SiteCrawler _crawler;
  List<ItemFilter> _filters = [new TypeItemFilter()];

  DataLoader(TrackedSite site) {
    switch (site) {
      case TrackedSite.Surugaya:
        _crawler = SurugayaCrawler();
        break;
      case TrackedSite.Mandarake:
        _crawler = MandarakeCrawler();
        break;
      case TrackedSite.Yahoo:
        _crawler = YahooCrawler();
        break;
      case TrackedSite.Mercari:
        _crawler = MercariCrawler();
        break;
      default:
    }
  }

  Future<List<MerchItem>> getMerch() async {
    var output = new List<MerchItem>();
    output.addAll((await _crawler.getMerch())
        .where((item) => _filters.every((filter) => !filter.isFiltered(item))));
    return output;
  }
}
