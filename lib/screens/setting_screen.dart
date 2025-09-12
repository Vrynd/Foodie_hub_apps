import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/app_bar.dart';
import 'package:restaurant_app/components/header.dart';
import 'package:restaurant_app/data/models/setting.dart';
import 'package:restaurant_app/provider/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    final themePreferencesProvider = context.read<ThemeProvider>();

    Future.microtask(() async {
      themePreferencesProvider.getSettingValue();
    });
  }

  Future<void> saveAction(bool isDarkMode) async {
    final set = Setting(isDarkMode: isDarkMode);
    final themeProvider = context.read<ThemeProvider>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    await themeProvider.saveSettingValue(set);

    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text(themeProvider.message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

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
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          children: [
            const Header(title: "Settings", subtitle: "Change your settings"),
            const SizedBox(height: 16),
            // Dark Mode
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.dark_mode_outlined,
                      size: 28,
                      color: Colors.blue,
                    ),
                    title: Text(
                      "Dark Mode",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      "Enable dark theme",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: saveAction,
                    ),
                  ),
                  Divider(
                    height: 0,
                    indent: 58,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.notifications_outlined,
                      size: 28,
                      color: Colors.pink,
                    ),
                    title: Text(
                      "Notifications",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      "Get updates about new restaurants",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    // trailing: Switch(
                    //   value: notifications,
                    //   onChanged: (val) {
                    //     setState(() {
                    //       notifications = val;
                    //     });
                    //   },
                    // ),
                  ),
                ],
              ),
            ),
            // Notifications
          ],
        ),
      ),
    );
  }
}
