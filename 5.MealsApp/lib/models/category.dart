import 'package:flutter/material.dart';

class Category {
  const Category(
      // kullanıcı color verirse verdiği color,
      // vermezse default değeri(orange) kullanılır.
      {required this.id,
      required this.name,
      this.color = Colors.orange});

  final String id;
  final String name;
  final Color color;
}
