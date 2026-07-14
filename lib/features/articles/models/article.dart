import 'package:flutter/material.dart';

class Article {
  final String id;
  final String title;
  final String subtitle;
  final String body;
  final String image;
  final Color color;

  const Article({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.image,
    required this.color,
  });
}
