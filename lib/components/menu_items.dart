import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/request/detail_request.dart';

class MenuItems extends StatelessWidget {
  final RestaurantMenu menus;
  const MenuItems({super.key, required this.menus});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.fastfood_outlined,
                size: 26,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.orange.shade700
                    : Colors.orange.shade300,
              ),

              const SizedBox.square(dimension: 8),

              Text(
                'Food Menu',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 1.3,
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  ...menus.foods.map(
                    (food) => Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            food.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.orange.shade700
                                      : Colors.orange.shade300,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox.square(dimension: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.local_drink_outlined,
                size: 26,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.lightBlue.shade700
                    : Colors.lightBlue.shade300,
              ),
              const SizedBox.square(dimension: 8),
              Text(
                'Drink Menu',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),

          const SizedBox.square(dimension: 12),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 1.3,
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  ...menus.drinks.map(
                    (drink) => Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            drink.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.lightBlue.shade700
                                      : Colors.lightBlue.shade300,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
