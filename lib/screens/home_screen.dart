import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/app_bar.dart';
import 'package:restaurant_app/components/header.dart';
import 'package:restaurant_app/components/list_items.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/resource/list_result_state.dart';
import 'package:restaurant_app/routes/app_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBarTemplate(
        title: Text(
          'FoodieHub',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
      ),
      ),
      body: SafeArea(
        child: Consumer<RestaurantListProvider>(
          builder: (context, provider, child) {
            final state = provider.resultState;
            return switch (state) {
              ListLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
              ListErrorState(error: var error) => Center(child: Text(error)),
              ListLoadedState(data: var restaurantList) => ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),
                itemCount: restaurantList.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Header(),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    );
                  }
                  final restaurant = restaurantList[index - 1];
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 16.0,
                    ),
                    child: ListItems(
                      restaurant: restaurant,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          NavigationRoute.detailRoute.name,
                          arguments: restaurant.id,
                        );
                      },
                    ),
                  );
                },
              ),
              _ => const Center(child: Text('Tidak Dapat Memuat Data')),
            };
          },
        ),
      ),
    );
  }
}
