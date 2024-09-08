import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/providers/favorites_provider.dart';

class Favorites extends ConsumerStatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  ConsumerState<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends ConsumerState<Favorites> {
  @override
  Widget build(BuildContext context) {
    List<Meal> favorites = ref.watch(favoriteMealsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoriler"),
      ),
      body: ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (ctx, index) => InkWell(
                onTap: () {},
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(favorites[index].name),
                )),
              )),
    );
  }
}




/**
 ** STATELESS  WIDGET -> CONSUMER WIDGET,
 * Burada build fonksiyonuna (WidgetRef ref) eklemen gerekir.
 * 
 ** STATEFUL WIDGET -> CONSUMER STATEFUL WIDGET,
 * Burada build fonksiyonuna WidgetRef eklemene gerek yok, ref doğrudan aktif olur.
 * 
 ** STATE -> CONSUMER STATE
 */