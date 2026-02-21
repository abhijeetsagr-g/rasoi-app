class RecipeModel {
  String recipeName;
  int prepTime;
  int cookTime;
  int totalTime;
  String cuisine;
  String course;
  String diet;
  String instructions;
  String url;
  List<String> ingredients;

  RecipeModel({
    required this.recipeName,
    required this.cuisine,
    required this.course,
    required this.diet,
    required this.instructions,
    required this.url,
    required this.prepTime,
    required this.cookTime,
    required this.totalTime,
    required this.ingredients,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      recipeName: json['recipe_name'] ?? '',
      prepTime: json['prep_time'] ?? 0,
      cookTime: json['cook_time'] ?? 0,
      totalTime: json['total_time'] ?? 0,
      cuisine: json['cuisine'] ?? '',
      course: json['course'] ?? '',
      diet: json['diet'] ?? '',
      instructions: json["instructions"] ?? '',
      url: json["url"] ?? '',
      ingredients:
          (json['ingredients'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}
