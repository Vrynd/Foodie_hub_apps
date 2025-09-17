import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/models/request/request.dart';
import 'package:restaurant_app/provider/local_database_provider.dart';
import 'package:restaurant_app/routes/app_route.dart';

class ListFavorite extends StatelessWidget {
  final RestaurantList restoFav;

  const ListFavorite({super.key, required this.restoFav});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              NavigationRoute.detailRoute.name,
              arguments: restoFav.id,
            );
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://restaurant-api.dicoding.dev/images/medium/${restoFav.pictureId}',
              width: 70,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            restoFav.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          subtitle: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_city_outlined,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.grey.shade400,
                size: 18,
              ),
              const SizedBox.square(dimension: 10),
              Text(
                restoFav.city,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox.square(dimension: 10),
              Icon(
                Icons.star_outlined,
                size: 18,
                color: (Theme.of(context).brightness == Brightness.light
                    ? Colors.amber.shade500
                    : Colors.amber.shade300),
              ),
              const SizedBox.square(dimension: 10),
              Text(
                restoFav.rating.toString(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          trailing: IconButton.outlined(
            iconSize: 26,
            style: IconButton.styleFrom(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            icon: Icon(
              Icons.bookmark,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade400
                  : Colors.grey.shade500,
            ),
            onPressed: () {
              context.read<LocalDatabaseProvider>().removeRestaurantById(
                restoFav.id,
              );
              context.read<LocalDatabaseProvider>().loadAllRestaurant();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${restoFav.name} removed from favorites',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                  ),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
