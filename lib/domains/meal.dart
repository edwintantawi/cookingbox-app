class Meal {
  final String id;
  final String title;
  final String image;

  const Meal({
    required this.id,
    required this.title,
    required this.image,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'],
      title: json['strMeal'],
      image: json['strMealThumb'],
    );
  }
}
