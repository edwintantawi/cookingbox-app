import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cookingbox_app/domains/meal.dart';
import 'package:cookingbox_app/domains/meal_category.dart';
import 'package:cookingbox_app/constants/api_endpoint.dart';

Future<List<MealCategory>> fetchMealCategories() async {
  final response = await http.get(Uri.parse(ApiEndpoint.categories));

  if (response.statusCode == 200) {
    List<MealCategory> mealCategories = [];
    final parsed = jsonDecode(response.body);

    for (var category in parsed['categories']) {
      mealCategories.add(MealCategory.fromJson(category));
    }

    return mealCategories;
  } else {
    throw Exception('Failed to load categories');
  }
}

Future<List<Meal>> fetchMealsByCategory(String category) async {
  final endpoint = '${ApiEndpoint.filter}?c=$category';
  final response = await http.get(Uri.parse(endpoint));

  if (response.statusCode == 200) {
    List<Meal> meals = [];
    final parsed = jsonDecode(response.body);

    for (var meal in parsed['meals']) {
      meals.add(Meal.fromJson(meal));
    }

    return meals;
  } else {
    throw Exception('Failed to load meals by category');
  }
}
