import 'package:flutter/material.dart';
import 'package:mealsapp/models/category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {Key? key, required this.category, required this.onCategoryClick})
      : super(key: key);
  final Category category;
  final void Function() onCategoryClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // tıklandığında patlayan renk
      splashColor: category.color,
      // onTap özelliği tıklamayı sağlar
      onTap: () {
        onCategoryClick();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              category.color.withOpacity(0.5), // böyle yazabilrsin
              category.color.withOpacity(0.9),
              //Colors.limeAccent.withOpacity(0.9),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Text(category.name), // tasarımı global theme den almalısın
        ),
      ),
    );
  }
}
