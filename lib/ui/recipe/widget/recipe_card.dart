import 'package:flutter/material.dart';
import 'package:rasoi_app/logic/model/recipe_model.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});
  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Name
            Text(
              recipe.recipeName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),

            const SizedBox(height: 12),

            // Time Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoTile("Prep", "${recipe.prepTime} min"),
                _infoTile("Cook", "${recipe.cookTime} min"),
                _infoTile("Total", "${recipe.totalTime} min"),
              ],
            ),

            const SizedBox(height: 16),

            Divider(color: Colors.grey.shade300),

            const SizedBox(height: 12),

            // Cuisine / Course
            _detailRow("Cuisine", recipe.cuisine),
            const SizedBox(height: 6),
            _detailRow("Course", recipe.course),
            const SizedBox(height: 6),

            // Diet
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withAlpha(90),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                recipe.diet,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _infoTile(String title, String value) {
  return Column(
    children: [
      Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      const SizedBox(height: 4),
      Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
    ],
  );
}

Widget _detailRow(String label, String value) {
  return Row(
    children: [
      Text("$label: ", style: const TextStyle(fontWeight: FontWeight.w600)),
      Expanded(child: Text(value)),
    ],
  );
}
