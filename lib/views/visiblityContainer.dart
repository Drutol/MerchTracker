import 'package:flutter/material.dart';

class VisibilityContainer extends StatelessWidget {
  final Widget child;
  final bool isVisible;
  VisibilityContainer({this.child, this.isVisible});

  @override
  Widget build(BuildContext context) => isVisible ? child : Container();
}
