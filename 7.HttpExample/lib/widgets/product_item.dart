import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.imgUrl,
    required this.title,
  }) : super(key: key);
  final String imgUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(imgUrl),
        Text(title),
      ],
    );
  }
}
