import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cookingbox_app/domains/food_category.dart';
import 'package:cookingbox_app/constants/api_endpoint.dart';

Future<List<FoodCategory>> fetchCategories() async {
  final response = await http.get(Uri.parse(ApiEndpoint.categories));

  if (response.statusCode == 200) {
    List<FoodCategory> foodCategories = [];
    final parsed = jsonDecode(response.body);

    for (var category in parsed['categories']) {
      foodCategories.add(FoodCategory.fromJson(category));
    }

    return foodCategories;
  } else {
    throw Exception('Failed to load categories');
  }
}
