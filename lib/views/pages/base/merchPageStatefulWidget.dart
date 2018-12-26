import 'package:flutter/material.dart';
import 'package:merch_tracker/dataLoader.dart';
import 'package:merch_tracker/models/merchItem.dart';
import 'package:merch_tracker/models/trackedSitesEnum.dart';

abstract class MerchPageStatefulWidget extends StatefulWidget {
  DataLoader dataLoader;
  List<MerchItem> merchItems = List();
  bool isLoading = true;
  
  MerchPageStatefulWidget(TrackedSite site) {
    dataLoader = DataLoader(site);
  }
}
