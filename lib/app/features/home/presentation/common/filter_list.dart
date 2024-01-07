// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class FilterList {
  final IconData icon;
  final String name;
  FilterList({
    required this.icon,
    required this.name,
  });
}

final filterList = [
  FilterList(
    icon: Icons.calendar_month_rounded,
    name: 'date',
  ),
  FilterList(
    icon: Icons.price_change_rounded,
    name: 'price',
  ),
  FilterList(
    icon: Icons.abc_rounded,
    name: 'abc',
  ),
];
