// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class FilterList {
  final IconData icon;
  FilterList({
    required this.icon,
  });
}

final filterList = [
  FilterList(
    icon: Icons.calendar_month_rounded,
  ),
  FilterList(
    icon: Icons.price_change_rounded,
  ),
  FilterList(
    icon: Icons.abc_rounded,
  ),
];
