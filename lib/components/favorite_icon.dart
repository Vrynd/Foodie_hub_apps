import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/models/request/request.dart';
import 'package:restaurant_app/provider/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';

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
    final favoriteListProvider  = context.read<FavoriteProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() {
      final restoInList = favoriteListProvider.checkItemFavorite(
        widget.restaurantList,
      );
      favoriteIconProvider.isFavorite = restoInList;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      onPressed: () {
        // todo-03-bookmark-05: replace this state using provider
        final favoriteListProvider = context.read<FavoriteProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isFormated = favoriteIconProvider.isFavorites;

        if (isFormated) {
          favoriteListProvider.removeBookmark(widget.restaurantList);
        } else {
          favoriteListProvider.addBookmark(widget.restaurantList);
        }
        favoriteIconProvider.isFavorite = !isFormated;
      },
      icon: Icon(
        context.watch<FavoriteIconProvider>().isFavorites
            ? Icons.favorite_rounded
            : Icons.favorite_border_rounded,
      ),
    );
  }
}
