import 'package:flutter/material.dart';
import 'package:readmore_expandable_text/readmore_expandable_text.dart';
import 'package:restaurant_app/components/favorite_icon.dart';
import 'package:restaurant_app/data/models/request/detail_request.dart';
import 'package:restaurant_app/data/models/request/request.dart';

class DetailItems extends StatelessWidget {
  final RestaurantDetail restaurantDetail;
  const DetailItems({super.key, required this.restaurantDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      restaurantDetail.name,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ),
                  FavoriteIconButton(
                    restaurantList: RestaurantList(
                      id: restaurantDetail.id,
                      name: restaurantDetail.name,
                      city: restaurantDetail.city,
                      pictureId: restaurantDetail.pictureId,
                      rating: restaurantDetail.rating,
                      description: restaurantDetail.description,
                    ),
                  ),
                ],
              ),
              const SizedBox.square(dimension: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_city_outlined,
                    size: 26,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade700
                        : Colors.grey.shade400,
                  ),
                  const SizedBox.square(dimension: 8),
                  Text(
                    restaurantDetail.city,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox.square(dimension: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 26,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Color(0xFF3C6838)
                        : Color(0xFF81C784),
                  ),
                  const SizedBox.square(dimension: 8),
                  Text(
                    restaurantDetail.address,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox.square(dimension: 14),
              ReadMoreExpandableText(
                text: restaurantDetail.description,
                maxLines: 3,
                textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                buttonStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                expandText: 'Read More',
                collapseText: 'Read Less',
                expandIcon: Icons.expand_more_rounded,
                collapseIcon: Icons.expand_less_rounded,
                iconColor: Theme.of(context).colorScheme.primary,
                iconSize: 20,
                buttonPadding: const EdgeInsets.only(top: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
