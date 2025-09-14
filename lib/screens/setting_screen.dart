import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/app_bar.dart';
import 'package:restaurant_app/components/header.dart';
import 'package:restaurant_app/data/models/setting.dart';
import 'package:restaurant_app/provider/schedule_preference_provider.dart';
import 'package:restaurant_app/provider/theme_preferences_provider.dart';

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
    final schedulePreferencesProvider = context.read<ScheduleProvider>();

    Future.microtask(() async {
      themePreferencesProvider.getSettingValue();
      schedulePreferencesProvider.getSettingValue();
    });
  }

  Future<void> saveThemeAction(bool isDarkMode) async {
    final set = Setting(
      isDarkMode: isDarkMode,
      isEnabled: context.read<ScheduleProvider>().isEnabled,
    );
    final themeProvider = context.read<ThemeProvider>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    await themeProvider.saveSettingValue(set);

    final modeText = isDarkMode
        ? "Dark mode activated"
        : "Light mode activated";
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(modeText, style: Theme.of(context).textTheme.bodyMedium),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> saveReminderAction(bool isEnabled) async {
    final set = Setting(
      isDarkMode: context.read<ThemeProvider>().isDarkMode,
      isEnabled: isEnabled,
    );
    final scheduleProvider = context.read<ScheduleProvider>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    await scheduleProvider.saveSettingValue(set);

    final scheduleText = isEnabled
        ? "Daily reminder activated"
        : "Daily reminder deactivated";
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(
          scheduleText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onInverseSurface,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final scheduleProvider = context.watch<ScheduleProvider>();

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
                color: Theme.of(context).colorScheme.surfaceContainerLow,
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
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      "Enable dark theme",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: saveThemeAction,
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
                      "Daily Reminder",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      "Get lunch reminder at 11 AM",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: Switch(
                      value: scheduleProvider.isEnabled,
                      onChanged: saveReminderAction,
                    ),
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
