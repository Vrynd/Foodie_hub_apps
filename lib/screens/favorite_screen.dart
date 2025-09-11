import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/app_bar.dart';
import 'package:restaurant_app/components/empty_favorite.dart';
import 'package:restaurant_app/components/header.dart';
import 'package:restaurant_app/components/list_items.dart';
import 'package:restaurant_app/provider/local_database_provider.dart';
import 'package:restaurant_app/routes/app_route.dart';
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllRestaurant();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      appBar: AppBarTemplate(
        title: Text(
          'FoodieHub',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<LocalDatabaseProvider>(
          builder: (context, value, child) {
            final favoriteList = value.restaurantList ?? [];
            if (favoriteList.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),
                itemCount: favoriteList.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Header(
                          title: 'Your Favorites',
                          subtitle: 'All the restaurants you liked',
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }

                  final restoFav = favoriteList[index - 1];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ListItems(
                      restaurant: restoFav,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          NavigationRoute.detailRoute.name,
                          arguments: restoFav.id,
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return EmptyFavorite();
            }
          },
        ),
      ),
    );
  }
}

