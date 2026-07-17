import 'package:flutter/material.dart';

class SessionTypeModel {
  final String title;
  final String subtitle;
  final int price;
  final IconData icon;
  final Color color;

  SessionTypeModel({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.icon,
    required this.color,
  });
}
