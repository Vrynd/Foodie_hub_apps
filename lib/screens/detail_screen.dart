import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/app_bar.dart';
import 'package:restaurant_app/components/detail_items.dart';
import 'package:restaurant_app/components/error_handling_api.dart';
import 'package:restaurant_app/components/header_detail.dart';
import 'package:restaurant_app/components/menu_items.dart';
import 'package:restaurant_app/components/review.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/resource/detail_result_state.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;
  const DetailScreen({super.key, required this.restaurantId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}
class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestaurantDetailProvider>().fetchRestaurantDetail(
        widget.restaurantId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBarTemplate(
        title: Consumer<RestaurantDetailProvider>(
          builder: (context, provider, _) {
            final state = provider.resultState;
            return Text(
              state is DetailLoadedState ? state.data.name : 'Loading...',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            );
          },
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            size: 28,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, provider, child) {
            final state = provider.resultState;
            switch (state) {
              case DetailLoadingState():
                return const Center(child: CircularProgressIndicator());

              case DetailErrorState(error: var errorMsg):
                final errorState = errorMsg.toLowerCase();
                String title;
                IconData icon;

                if (errorState.contains('no internet')) {
                  title = 'No Internet Connection';
                  icon = Icons.wifi_off;
                } else if (errorState.contains('request timeout')) {
                  title = 'Request Timeout';
                  icon = Icons.access_time;
                } else {
                  title = 'Something went wrong';
                  icon = Icons.error;
                }

                return ErrorHandlingApi(
                  title: title,
                  message: errorMsg.replaceAll('Exception: ', ''),
                  iconData: icon,
                  onRetry: () {
                    context
                        .read<RestaurantDetailProvider>()
                        .fetchRestaurantDetail(widget.restaurantId);
                    ();
                  },
                );

              case DetailLoadedState(data: var restaurant):
                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailImage(
                          pictureId: restaurant.pictureId,
                          rating: restaurant.rating,
                          categories: restaurant.categories,
                        ),
                        const SizedBox(height: 10),
                        DetailItems(restaurantDetail: restaurant),
                        const SizedBox(height: 10),
                        MenuItems(menus: restaurant.menus),
                        const SizedBox(height: 10),
                        CustomerReview(reviews: restaurant.customerReviews),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );

              default:
                return const Center(child: Text('Unable to load data'));
            }
          },
        ),
      ),
    );
  }
}
