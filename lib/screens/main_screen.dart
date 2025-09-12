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
        elevation: 2.0,
        labelTextStyle: WidgetStatePropertyAll(
          Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        shadowColor: Theme.of(context).colorScheme.shadow,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        selectedIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          context.read<IndexNavProvider>().indextBottomNavBar = index;
        },
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              size: 28,
              color: Theme.of(context).colorScheme.secondary,
            ),
            selectedIcon: Icon(
              Icons.home_outlined,
              size: 28,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: "Home",
            tooltip: "Home",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.search_outlined,
              size: 28,
              color: Theme.of(context).colorScheme.secondary,
            ),
            selectedIcon: Icon(
              Icons.search_outlined,
              size: 28,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: "Search",
            tooltip: "Search",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.bookmark_border_outlined,
              size: 28,
              color: Theme.of(context).colorScheme.secondary,
            ),
            selectedIcon: Icon(
              Icons.bookmark_border_outlined,
              size: 28,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: "Favorite",
            tooltip: "Favorite",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.notifications_on_outlined,
              size: 28,
              color: Theme.of(context).colorScheme.secondary,
            ),
            selectedIcon: Icon(
              Icons.notifications_on_outlined,
              size: 28,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: "Reminder",
            tooltip: "Reminder",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.settings_outlined,
              size: 28,
              color: Theme.of(context).colorScheme.secondary,
            ),
            selectedIcon: Icon(
              Icons.settings_outlined,
              size: 28,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: "Setting",
            tooltip: "Setting",
          ),
        ],
      ),
    );
  }
}
