class RecipeQuery {
  final String? name;
  final String? cuisine;
  final String? diet;
  final String? course;
  final int? maxPrep;
  final int? maxCook;
  final int? maxTotal;
  final String? sort;
  final int? limit;

  const RecipeQuery({
    this.name,
    this.cuisine,
    this.diet,
    this.course,
    this.maxPrep,
    this.maxCook,
    this.maxTotal,
    this.sort,
    this.limit,
  });

  RecipeQuery copyWith({
    String? name,
    String? cuisine,
    String? diet,
    String? course,
    int? maxPrep,
    int? maxCook,
    int? maxTotal,
    String? sort,
    int? limit,
  }) {
    return RecipeQuery(
      name: name ?? this.name,
      cuisine: cuisine ?? this.cuisine,
      diet: diet ?? this.diet,
      course: course ?? this.course,
      maxPrep: maxPrep ?? this.maxPrep,
      maxCook: maxCook ?? this.maxCook,
      maxTotal: maxTotal ?? this.maxTotal,
      sort: sort ?? this.sort,
      limit: limit ?? this.limit,
    );
  }
}
