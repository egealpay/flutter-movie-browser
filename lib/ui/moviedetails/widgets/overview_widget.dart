import 'package:flutter/material.dart';

class OverviewWidget extends StatelessWidget {
  final String overview;

  OverviewWidget(this.overview);

  @override
  Widget build(BuildContext context) {
    return Text(overview);
  }
}