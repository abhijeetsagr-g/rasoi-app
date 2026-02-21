import 'package:flutter/material.dart';
import 'package:rasoi_app/logic/model/recipe_model.dart';
import 'package:rasoi_app/ui/recipe/widget/ingredients_card.dart';
import 'package:rasoi_app/ui/recipe/widget/instruction_card.dart';
import 'package:rasoi_app/ui/recipe/widget/recipe_card.dart';

class RecipeView extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    List<String> steps = recipe.instructions
        .split('.')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RecipeCard(recipe: recipe),
            IngredientsCard(ingredients: recipe.ingredients),
            InstructionCard(steps: steps),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
