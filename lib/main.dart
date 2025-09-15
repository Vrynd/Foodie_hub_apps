import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/database/local_database_service.dart';
import 'package:restaurant_app/data/service/http_service.dart';
import 'package:restaurant_app/data/service/local_notification_service.dart';
import 'package:restaurant_app/data/service/schedule_preferences_service.dart';
import 'package:restaurant_app/data/service/theme_preferences_service.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/provider/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/index_nav_provider.dart';
import 'package:restaurant_app/provider/list_provider.dart';
import 'package:restaurant_app/provider/local_database_provider.dart';
import 'package:restaurant_app/provider/local_notification_provider.dart';
import 'package:restaurant_app/provider/payload_provider.dart';
import 'package:restaurant_app/provider/schedule_preference_provider.dart';
import 'package:restaurant_app/provider/theme_preferences_provider.dart';
import 'package:restaurant_app/screens/detail_screen.dart';
import 'package:restaurant_app/screens/main_screen.dart';
import 'package:restaurant_app/themes/app_theme.dart';
import 'package:restaurant_app/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final notificationAppLaunchDetails = await flutterLocalNotificationsPlugin
      .getNotificationAppLaunchDetails();

  String route = NavigationRoute.mainRoute.name;
  String? payload;

  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    final notificationResponse =
        notificationAppLaunchDetails!.notificationResponse;
    route = NavigationRoute.detailRoute.name;
    payload = notificationResponse?.payload;
  }

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => HttpService()),

        Provider(
          create: (context) => LocalNotificationService()
            ..init()
            ..configureLocalTimeZone(),
        ),

        ChangeNotifierProvider(
          create: (context) => PayloadProvider(payload: payload),
        ),

        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
          )..requestPermission(),
        ),

        Provider(create: (context) => ThemePreferencesService(prefs)),
        Provider(create: (context) => SchedulePreferencesService(prefs)),

        ChangeNotifierProvider(
          create: (context) =>
              ThemeProvider(context.read<ThemePreferencesService>()),
        ),

        ChangeNotifierProvider(
          create: (context) => ScheduleProvider(
            context.read<SchedulePreferencesService>(),
            context.read<LocalNotificationProvider>(),
          ),
        ),

        ChangeNotifierProvider(create: (context) => IndexNavProvider()),

        Provider(create: (context) => LocalDatabaseService()),

        ChangeNotifierProvider(
          create: (context) =>
              LocalDatabaseProvider(context.read<LocalDatabaseService>()),
        ),

        ChangeNotifierProvider(create: (context) => FavoriteIconProvider()),

        Provider(create: (context) => ApiService()),

        ChangeNotifierProvider(
          create: (context) =>
              RestaurantListProvider(context.read<ApiService>()),
        ),

        ChangeNotifierProvider(
          create: (context) =>
              RestaurantDetailProvider(context.read<ApiService>()),
        ),
      ],
      child: MyApp(initialRoute: route),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FoodieHub',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialRoute: initialRoute,
          routes: {
            NavigationRoute.mainRoute.name: (context) => const MainScreen(),
            NavigationRoute.detailRoute.name: (context) {
              final args =
                  ModalRoute.of(context)!.settings.arguments as String?;
              if (args != null) {
                return DetailScreen(restaurantId: args);
              } else {
                final payload = context.watch<PayloadProvider>().payload;
                if (payload != null) {
                  return DetailScreen(restaurantId: payload);
                }
                return const MainScreen();
              }
            },
          },
        );
      },
    );
  }
}