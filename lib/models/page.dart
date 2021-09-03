import 'package:flutter/material.dart';

class Pages {
  final Icon ikon;
  final String title;
  final Color color;

  Function(BuildContext ctx) fun;

  Pages(
    this.ikon,
    this.title,
    this.color,
    this.fun,
  );
}
