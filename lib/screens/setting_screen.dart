import 'package:flutter/material.dart';
import 'package:restaurant_app/components/app_bar.dart';
import 'package:restaurant_app/components/header.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool darkMode = false;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
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
                      value: darkMode,
                      onChanged: (val) {
                        setState(() {
                          darkMode = val;
                        });
                      },
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
                    trailing: Switch(
                      value: notifications,
                      onChanged: (val) {
                        setState(() {
                          notifications = val;
                        });
                      },
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
