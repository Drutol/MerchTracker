import 'package:flutter/material.dart';
import 'package:merch_tracker/views/pages/base/merchPageStatefulWidget.dart';

abstract class MerchPageState<TPage extends MerchPageStatefulWidget>
    extends State<TPage> {
  @override
  void initState() {
    super.initState();
    if (widget.merchItems.length == 0) refreshList();
  }

  @override
  bool get wantKeepAlive => true;

  Future refreshList() async {
    var items = await widget.dataLoader.getMerch();
    if (mounted) {
      setState(() {
        widget.merchItems = items;
        widget.isLoading = false;
      });
    }
  }
}
