class MealCategory {
  final String id;
  final String title;
  final String description;
  final String image;

  const MealCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  factory MealCategory.fromJson(Map<String, dynamic> json) {
    return MealCategory(
      id: json['idCategory'],
      title: json['strCategory'],
      description: json['strCategoryDescription'],
      image: json['strCategoryThumb'],
    );
  }
}
