import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

late Size screenSize;

const Color kBackgroundColor = Color(0xFFF5F5DC);

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('EEEE dd MMM');
  return formatter.format(date);
}

Future<bool> isFirstAppLaunch() async {
  return true;
}
