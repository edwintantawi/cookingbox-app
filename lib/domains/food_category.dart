class FoodCategory {
  final String id;
  final String title;
  final String description;
  final String image;

  const FoodCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  factory FoodCategory.fromJson(Map<String, dynamic> json) {
    return FoodCategory(
      id: json['idCategory'],
      title: json['strCategory'],
      description: json['strCategoryDescription'],
      image: json['strCategoryThumb'],
    );
  }
}
