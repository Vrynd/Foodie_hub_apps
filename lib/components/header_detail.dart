import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/request/detail_request.dart';

class DetailImage extends StatelessWidget {
  final String pictureId;
  final double rating;
  final List<CategoryRestaurant> categories;

  const DetailImage({
    super.key,
    required this.pictureId,
    required this.rating,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.network(
            'https://restaurant-api.dicoding.dev/images/medium/$pictureId',
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 16.0,
          right: 16.0,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20.0),
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 1.3,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_outlined,
                    size: 26,
                    color: (Theme.of(context).brightness == Brightness.light
                        ? Colors.amber.shade500
                        : Colors.amber.shade300),
                  ),
                  const SizedBox.square(dimension: 6),
                  Text(
                    rating.toString(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 15.0,
          left: 16.0,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: categories.map((categoriesItems) {
                return Container(
                  margin: const EdgeInsets.only(right: 6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    categoriesItems.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
