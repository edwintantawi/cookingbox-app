import 'package:cookingbox_app/utils/http.dart';
import 'package:cookingbox_app/domains/meal.dart';
import 'package:cookingbox_app/domains/meal_category.dart';
import 'package:cookingbox_app/constants/api_endpoint.dart';

Future<List<MealCategory>> fetchMealCategories() async {
  final response = await http.get(
    ApiEndpoint.categories,
    options: cacheOptions,
  );

  if (response.statusCode == 200) {
    List<MealCategory> mealCategories = [];

    for (var category in response.data['categories']) {
      mealCategories.add(MealCategory.fromJson(category));
    }

    return mealCategories;
  } else {
    throw Exception('Failed to load categories');
  }
}

Future<List<Meal>> fetchMealsByCategory(String category) async {
  final endpoint = '${ApiEndpoint.filter}?c=$category';
  final response = await http.get(
    endpoint,
    options: cacheOptions,
  );

  if (response.statusCode == 200) {
    List<Meal> meals = [];

    for (var meal in response.data['meals']) {
      meals.add(Meal.fromJson(meal));
    }

    return meals;
  } else {
    throw Exception('Failed to load meals by category');
  }
}
