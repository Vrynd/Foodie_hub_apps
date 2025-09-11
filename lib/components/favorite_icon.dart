import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/models/request/request.dart';
import 'package:restaurant_app/provider/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/local_database_provider.dart';

class FavoriteIconButton extends StatefulWidget {
  final RestaurantList restaurantList;
  const FavoriteIconButton({super.key, required this.restaurantList});

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  @override
  void initState() {
    super.initState();
    final localDatabaseProvider = context.read<LocalDatabaseProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() async {
      await localDatabaseProvider.loadRestaurantById(widget.restaurantList.id);
      final value = localDatabaseProvider.checkItemFavorite(
        widget.restaurantList.id,
      );
      favoriteIconProvider.isFavorite = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      onPressed: () async {
        final localDatabaseProvider = context.read<LocalDatabaseProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isFavorited = favoriteIconProvider.isFavorites;

        if (!isFavorited) {
          await localDatabaseProvider.addFavorite(widget.restaurantList);
        } else {
          await localDatabaseProvider.removeRestaurantById(
            widget.restaurantList.id,
          );
        }
        favoriteIconProvider.isFavorite = !isFavorited;
        localDatabaseProvider.loadAllRestaurant();
      },
      icon: Icon(
        context.watch<FavoriteIconProvider>().isFavorites
            ? Icons.favorite_rounded
            : Icons.favorite_border_rounded,
      ),
    );
  }
}
