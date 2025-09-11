import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/index_nav_provider.dart';
import 'package:restaurant_app/screens/favorite_screen.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screens/notification_screen.dart';
import 'package:restaurant_app/screens/search_screen.dart';
import 'package:restaurant_app/screens/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => const HomeScreen(),
            1 => const SearchScreen(),
            2 => const FavoriteScreen(),
            3 => const NotificationScreen(),
            4 => const SettingScreen(),
            _ => const HomeScreen(),
          };
        },
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        surfaceTintColor: Theme.of(context).colorScheme.onPrimary,
        selectedIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        onDestinationSelected: (index) {
          context.read<IndexNavProvider>().indextBottomNavBar = index;
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
            tooltip: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: "Search",
            tooltip: "Search"
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: "Favorites",
            tooltip: "Favorites",
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: "Reminder",
            tooltip: "Reminder",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: "Settings",
            tooltip: "Settings",
          )
        ],
      ),
    );
  }
}
