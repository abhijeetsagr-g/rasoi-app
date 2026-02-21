// ui/recipe/widget/recipe_filter_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rasoi_app/logic/providers/recipe_provider.dart';

class RecipeFilterPanel extends ConsumerWidget {
  const RecipeFilterPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedQuery = ref.watch(recipeQueryProvider);
    final cuisinesAsync = ref.watch(cuisinesProvider);
    final coursesAsync = ref.watch(coursesProvider);
    final dietAsync = ref.watch(dietProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filters',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: () {
                  ref.read(recipeQueryProvider.notifier).clearFilters();
                },
                icon: const Icon(Icons.clear_all, size: 18),
                label: const Text('Clear All'),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Cuisine Filter
          cuisinesAsync.when(
            data: (cuisines) => _FilterRow(
              label: 'Cuisine',
              options: cuisines,
              selectedValue: selectedQuery.cuisine,
              onChanged: (value) {
                ref.read(recipeQueryProvider.notifier).updateCuisine(value);
              },
            ),
            loading: () => const _LoadingRow(label: 'Cuisine'),
            error: (_, _) => const SizedBox.shrink(),
          ),

          const SizedBox(height: 12),

          // Course Filter
          coursesAsync.when(
            data: (courses) => _FilterRow(
              label: 'Course',
              options: courses,
              selectedValue: selectedQuery.course,
              onChanged: (value) {
                ref.read(recipeQueryProvider.notifier).updateCourse(value);
              },
            ),
            loading: () => const _LoadingRow(label: 'Course'),
            error: (_, _) => const SizedBox.shrink(),
          ),

          const SizedBox(height: 12),

          // Diet Filter
          dietAsync.when(
            data: (diets) => _FilterRow(
              label: 'Diet',
              options: diets,
              selectedValue: selectedQuery.diet,
              onChanged: (value) {
                ref.read(recipeQueryProvider.notifier).updateDiet(value);
              },
            ),
            loading: () => const _LoadingRow(label: 'Diet'),
            error: (_, _) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const _FilterRow({
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];
              final isSelected = selectedValue == option;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(option),
                  selected: isSelected,
                  onSelected: (_) {
                    onChanged(isSelected ? null : option);
                  },
                  selectedColor: Theme.of(context).colorScheme.primaryContainer,
                  checkmarkColor: Theme.of(
                    context,
                  ).colorScheme.onPrimaryContainer,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LoadingRow extends StatelessWidget {
  final String label;

  const _LoadingRow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const SizedBox(
          height: 40,
          child: Center(
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
      ],
    );
  }
}
