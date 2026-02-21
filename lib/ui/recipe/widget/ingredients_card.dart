import 'package:flutter/material.dart';

class IngredientsCard extends StatefulWidget {
  final List<String> ingredients;

  const IngredientsCard({super.key, required this.ingredients});

  @override
  State<IngredientsCard> createState() => _IngredientsCardState();
}

class _IngredientsCardState extends State<IngredientsCard> {
  late List<bool> checked;

  @override
  void initState() {
    super.initState();
    checked = List.generate(widget.ingredients.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.ingredients.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  checked[index] = !checked[index];
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    // Checkbox
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: checked[index]
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        widget.ingredients[index],
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
