import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/models/meal.dart';

final mealsProvider = Provider((ProviderRef ref) {
  return const [
    Meal(
        id: "4",
        categoryId: "4",
        name: "Katmer",
        imageUrl:
            "https://nostalji.markopos.com/views/nostalji/nostalji_500X-katmer.jpeg",
        ingredients: ["Şeker", "Yağ", "Antep Fıstığı"]),
  ];
});
