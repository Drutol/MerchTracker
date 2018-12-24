import 'package:merch_tracker/interfaces/itemFilter.dart';
import 'package:merch_tracker/models/merchItem.dart';

class TypeItemFilter implements ItemFilter {

  List<String> _filteredKeyWords = [
    "Windows7",
    "カオス",
    "アニメ系CD"
  ];

  @override
  bool isFiltered(MerchItem item) {
    if (item.type?.isNotEmpty ?? false) {
      return _filteredKeyWords.any((keyword) => item.type.contains(keyword));
    }

    return false;
  }
}
