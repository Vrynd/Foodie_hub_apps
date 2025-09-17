import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/request/request.dart';
import 'package:restaurant_app/routes/app_route.dart';

class SearchResult extends StatelessWidget {
  final RestaurantList restaurant;
  const SearchResult({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 6),
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              NavigationRoute.detailRoute.name,
              arguments: restaurant.id,
            );
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
              width: 60,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            restaurant.name,
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface,
                ),
          ),
          subtitle: Row(
            children: [
              Icon(
                Icons.location_city_outlined,
                color:
                    Theme.of(context).brightness ==
                        Brightness.light
                    ? Colors.grey.shade700
                    : Colors.grey.shade400,
                size: 18,
              ),
              const SizedBox.square(dimension: 10),
              Text(
                restaurant.city,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
          trailing: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16.0),
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerLowest,
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.outlineVariant,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 16,
                vertical: 2,
              ),
              child: Text(
                restaurant.rating.toString(),
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(
                      color:
                          (Theme.of(context).brightness ==
                              Brightness.light
                          ? Colors.amber.shade500
                          : Colors.amber.shade300),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
