import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rasoi_app/logic/model/recipe_model.dart';

abstract class RecipeService {
  static const String _url = "https://rasoi-api-ctz9.onrender.com/";
  static Future<List<RecipeModel>> getAllRecipes({
    String? name,
    String? cuisine,
    String? diet,
    String? course,
    int? maxPrep,
    int? maxCook,
    int? maxTotal,
    String? sort,
    int? limit,
  }) async {
    final queryParams = <String, String>{};

    if (name != null) queryParams['name'] = name;
    if (cuisine != null) queryParams['cuisine'] = cuisine;
    if (diet != null) queryParams['diet'] = diet;
    if (course != null) queryParams['course'] = course;
    if (maxPrep != null) queryParams['max_prep'] = maxPrep.toString();
    if (maxCook != null) queryParams['max_cook'] = maxCook.toString();
    if (maxTotal != null) queryParams['max_total'] = maxTotal.toString();
    if (sort != null) queryParams['sort'] = sort;
    if (limit != null) queryParams['limit'] = limit.toString();

    final Uri recipeUrl = Uri.parse(
      "${_url}recipes",
    ).replace(queryParameters: queryParams);

    final response = await http.get(recipeUrl);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => RecipeModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load recipes");
    }
  }

  static Future<List<String>> getCuisines() async {
    final Uri url = Uri.parse("${_url}recipes/cuisines");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => e.toString()).toList();
    } else {
      throw Exception("Failed to Load Cuisines");
    }
  }

  static Future<List<String>> getCourse() async {
    final Uri url = Uri.parse("${_url}recipes/course");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => e.toString()).toList();
    } else {
      throw Exception("Failed to Load Courses");
    }
  }

  static Future<List<String>> getDiet() async {
    final Uri url = Uri.parse("${_url}recipes/diet");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => e.toString()).toList();
    } else {
      throw Exception("Failed to Load Diet");
    }
  }
}
