import 'package:merch_tracker/models/merchItem.dart';

abstract class ItemFilter {
  bool isFiltered(MerchItem item);
}