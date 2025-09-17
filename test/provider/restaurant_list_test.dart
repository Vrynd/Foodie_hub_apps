import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/request/request.dart';
import 'package:restaurant_app/data/models/response/response.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/resource/list_result_state.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;
  late RestaurantListProvider provider;

  setUp(() {
    mockApiService = MockApiService();
    provider = RestaurantListProvider(mockApiService);
  });

  group('Restaurant list provider', () {
    test(
      'Ensure the initial state of the provider is defined (ListNoneState)',
      () {
        final initState = provider.resultState;
        expect(initState, isA<ListNoneState>());
      },
    );

    test(
      'Ensure to return a list of restaurants when API data retrieval is successful (LoadedState)',
      () async {
        when(() => mockApiService.getRestaurantList()).thenAnswer(
          (_) async => RestaurantListResponse(
            error: false,
            message: "success",
            count: 1,
            restaurants: [
              RestaurantList(
                id: "1",
                name: "Resturant 1",
                description: "Description Restaurant 1",
                pictureId: "picture1",
                city: "city 1",
                rating: 4.2,
              ),
            ],
          ),
        );

        await provider.fetchRestaurantList();
        final state = provider.resultState;

        expect(state, isA<ListLoadedState>());
      },
    );

    test(
      'Ensure to return error state when API throws an exception (ListErrorState)',
      () async {
        when(
          () => mockApiService.getRestaurantList(),
        ).thenThrow(Exception("Failed To Load Restaurant List"));

        await provider.fetchRestaurantList();
        final state = provider.resultState;

        expect(state, isA<ListErrorState>());
      },
    );

    test(
      'Ensure to return error state when API throws SocketException (ListErrorState)',
      () async {
        when(
          () => mockApiService.getRestaurantList(),
        ).thenThrow(SocketException('No Internet Connection'));

        await provider.fetchRestaurantList();
        final state = provider.resultState;

        expect(state, isA<ListErrorState>());
      },
    );

    test(
      'Ensure to return error state when API throws TimeoutException (ListErrorState)',
      () async {
        when(
          () => mockApiService.getRestaurantList(),
        ).thenThrow(TimeoutException('Connection Timeout'));

        await provider.fetchRestaurantList();
        final state = provider.resultState;

        expect(state, isA<ListErrorState>());
      },
    );
  });
}
