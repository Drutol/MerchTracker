import '../models/merchItem.dart';

abstract class SiteCrawler {
  Future<List<MerchItem>> getMerch();
}