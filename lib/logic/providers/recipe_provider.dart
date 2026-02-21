import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rasoi_app/logic/model/recipe_model.dart';
import 'package:rasoi_app/logic/model/recipe_query.dart';
import 'package:rasoi_app/logic/services/recipe_service.dart';

// QUERY CONTROLLER (Modern Way)

class RecipeQueryNotifier extends Notifier<RecipeQuery> {
  @override
  RecipeQuery build() {
    return const RecipeQuery(limit: 14);
  }

  void updateSearch(String value) {
    state = state.copyWith(name: value.isEmpty ? null : value);
  }

  void updateCuisine(String? cuisine) {
    state = state.copyWith(cuisine: cuisine);
  }

  void updateDiet(String? diet) {
    state = state.copyWith(diet: diet);
  }

  void updateCourse(String? course) {
    state = state.copyWith(course: course);
  }

  void clearFilters() {
    state = const RecipeQuery(limit: 14);
  }
}

final recipeQueryProvider = NotifierProvider<RecipeQueryNotifier, RecipeQuery>(
  RecipeQueryNotifier.new,
);

// RECIPES FETCHER
final recipesProvider = FutureProvider<List<RecipeModel>>((ref) async {
  final query = ref.watch(recipeQueryProvider);
  return RecipeService.getAllRecipes(
    name: query.name,
    cuisine: query.cuisine,
    diet: query.diet,
    course: query.course,
    maxPrep: query.maxPrep,
    maxCook: query.maxCook,
    maxTotal: query.maxTotal,
    sort: query.sort,
    limit: query.limit,
  );
});

// FILTER DATA PROVIDERS
final cuisinesProvider = FutureProvider.autoDispose<List<String>>((ref) {
  return RecipeService.getCuisines();
});

final coursesProvider = FutureProvider.autoDispose<List<String>>((ref) {
  return RecipeService.getCourse();
});

final dietProvider = FutureProvider.autoDispose<List<String>>((ref) {
  return RecipeService.getDiet();
});
