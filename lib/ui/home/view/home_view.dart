import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rasoi_app/logic/providers/recipe_provider.dart';
import 'package:rasoi_app/ui/home/widget/recipe_filter_panel.dart';
import 'package:rasoi_app/ui/recipe/view/recipe_view.dart';
import 'package:rasoi_app/ui/recipe/widget/recipe_card.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  bool _showFilters = false;

  @override
  Widget build(BuildContext context) {
    final recipesAsync = ref.watch(recipesProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
            hintText: "Search",
          ),
          onChanged: (value) {
            ref.read(recipeQueryProvider.notifier).updateSearch(value);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              _showFilters ? Icons.filter_list_off : Icons.filter_list,
            ),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showFilters) const RecipeFilterPanel(),
          Expanded(
            child: RefreshIndicator.adaptive(
              onRefresh: () async {
                ref.invalidate(recipesProvider);
                await ref.read(recipesProvider.future);
              },
              child: recipesAsync.when(
                data: (recipes) {
                  if (recipes.isEmpty) {
                    return const Center(
                      child: Text(
                        "I guess you misspelled something",
                        style: TextStyle(fontSize: 14),
                      ),
                    );
                  }
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RecipeView(recipe: recipes[index]),
                          ),
                        ),
                        child: ListTile(
                          title: RecipeCard(recipe: recipes[index]),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text(error.toString())),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
