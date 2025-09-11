import 'package:flutter/material.dart';
import 'package:restaurant_app/components/header.dart';

class EmptyFavorite extends StatelessWidget {
  const EmptyFavorite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          child: Header(
            title: "Your Favorites",
            subtitle: "Restaurants you love the most",
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 14,
              right: 14,
              bottom: 16,
              // vertical: 16,
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.bookmarks_outlined,
                      size: 84,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox.square(dimension: 16),
                    Text(
                      "No favorites yet",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox.square(dimension: 8),
                    Text(
                      "Start exploring restaurants and add them to your favorites!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
