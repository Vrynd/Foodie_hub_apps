import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/app_bar.dart';
import 'package:restaurant_app/components/empty_handling_ui.dart';
import 'package:restaurant_app/components/error_handling_api.dart';
import 'package:restaurant_app/components/header.dart';
import 'package:restaurant_app/components/search_bar.dart';
import 'package:restaurant_app/components/search_result.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/resource/search_result_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    final provider = context.read<RestaurantSearchProvider>();
    if (query.isNotEmpty) {
      provider.searchRestaurant(query);
    } else {
      provider.resetSearch();
    }
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
        child: Consumer<RestaurantSearchProvider>(
          builder: (context, provider, child) {
            final state = provider.resultState;
            switch (state) {
              case SearchNoneState():
              case SearchLoadingState():
                return EmptyHandlingInterface(
                  header: Header(
                    child: SearchBarHeader(
                      controller: _searchController,
                      onSearch: _onSearch,
                    ),
                  ),
                  isLoading: state is SearchLoadingState,
                  iconHeader: Icons.search_outlined,
                  title: 'Let’s Find Something!',
                  description: 'Start typing a keyword above to find restaurants.',
                );

              case SearchErrorState(error: var error):
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
                  icon = Icons.error_outline;
                }

                return ErrorHandlingApi(
                  title: title,
                  message: error.replaceAll('Exception: ', ''),
                  iconData: icon,
                  onRetry: () {
                    context.read<RestaurantSearchProvider>().searchRestaurant(
                      _searchController.text,
                    );
                  },
                );

              case SearchLoadedState(data: var restaurantList):
                if (restaurantList.isEmpty) {
                  return EmptyHandlingInterface(
                    header: Header(
                      child: SearchBarHeader(
                        controller: _searchController,
                        onSearch: _onSearch,
                      ),
                    ),
                    iconHeader: Icons.search_off_outlined,
                    title: 'No Result Found',
                    description: 'Try searching with a different keyword or spelling',
                  );
                } else {
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
                          children: [
                            Header(
                              child: SearchBarHeader(
                                controller: _searchController,
                                onSearch: _onSearch,
                              ),
                            ),
                            const SizedBox.square(dimension: 16),
                          ],
                        );
                      }
                      final restaurant = restaurantList[index - 1];
                      return SearchResult(restaurant: restaurant);
                    },
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
