import 'package:mealsapp/models/category.dart';
import 'package:flutter/material.dart';
import 'package:mealsapp/models/meal.dart';

const categoryList = [
  Category(id: "1", name: "Başlangıçlar", color: Colors.purple),
  Category(id: "2", name: "Ara Sıcaklar", color: Colors.red),
  Category(id: "3", name: "Ana Yemekler", color: Colors.blue),
  Category(id: "4", name: "Tatlılar", color: Colors.yellow),
  Category(id: "5", name: "İçecekler")
];

const mealList = [
  Meal(
      id: "1",
      categoryId: "1",
      name: "Kabak Tarator",
      imageUrl:
          "https://i.pinimg.com/originals/40/ed/a4/40eda49db95ad121ed42d933349dab87.jpg",
      ingredients: ["Şeker", "Yağ", "Antep Fıstığı"]),
  Meal(
      id: "2",
      categoryId: "2",
      name: "Mercimek Çorbası",
      imageUrl:
          "https://cdn.yemek.com/uploads/2019/04/salcali-mercimek-corbasi-tarifi.jpg",
      ingredients: ["Mercimek", "Yağ", "Salça", "Su", "Tuz"]),
  Meal(
      id: "3",
      categoryId: "3",
      name: "Tavuk Kanat",
      imageUrl: "https://galeri14.uludagsozluk.com/890/tavuk-kanat_1600828.jpg",
      ingredients: ["Baharatlar", "Yağ", "Tavuk"]),
  Meal(
      id: "4",
      categoryId: "4",
      name: "Katmer",
      imageUrl:
          "https://nostalji.markopos.com/views/nostalji/nostalji_500X-katmer.jpeg",
      ingredients: ["Şeker", "Yağ", "Antep Fıstığı"]),
];
