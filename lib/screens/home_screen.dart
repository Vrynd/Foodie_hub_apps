import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/app_bar.dart';
import 'package:restaurant_app/components/error_handling_api.dart';
import 'package:restaurant_app/components/header.dart';
import 'package:restaurant_app/components/list_items.dart';
import 'package:restaurant_app/data/service/local_notification_service.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/provider/payload_provider.dart';
import 'package:restaurant_app/resource/list_result_state.dart';
import 'package:restaurant_app/routes/app_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) {
      context.read<PayloadProvider>().payload = payload;
      Navigator.pushNamed(
        context,
        NavigationRoute.detailRoute.name,
        arguments: payload,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _configureSelectNotificationSubject();
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  void dispose() {
    selectNotificationStream.close();
    super.dispose();
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
            switch (state) {
              case ListLoadingState():
                return const Center(child: CircularProgressIndicator());

              case ListErrorState(error: var error):
                final errorState = error.toLowerCase();
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
                  message: error.replaceAll('Exception: ', ''),
                  iconData: icon,
                  onRetry: () {
                    context
                        .read<RestaurantListProvider>()
                        .fetchRestaurantList();
                  },
                );

              case ListLoadedState(data: var restaurantList):
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 16,
                  ),
                  itemCount: restaurantList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [const Header(), const SizedBox(height: 16)],
                      );
                    }
                    final restaurant = restaurantList[index - 1];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
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
