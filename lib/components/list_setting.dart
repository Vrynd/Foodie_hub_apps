import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/schedule_preference_provider.dart';
import 'package:restaurant_app/provider/theme_preferences_provider.dart';

class ListSetting extends StatelessWidget {
  final Future<void> Function(bool isDarkMode) onSaveTheme;
  final Future<void> Function(bool isEnabled) onSaveReminder;

  const ListSetting({
    super.key,
    required this.onSaveTheme,
    required this.onSaveReminder,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final scheduleProvider = context.watch<ScheduleProvider>();

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
      child: Column(
        children: [
          // Dark Mode
          ListTile(
            leading: const Icon(
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
              onChanged: onSaveTheme,
            ),
          ),
          Divider(
            height: 0,
            indent: 58,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          // Daily Reminder
          ListTile(
            leading: const Icon(
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
              onChanged: onSaveReminder,
            ),
          ),
        ],
      ),
    );
  }
}
