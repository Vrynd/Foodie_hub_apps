import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? child;
  const Header({super.key, this.title, this.subtitle, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title ?? 'Hello!',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(
            subtitle ?? 'What do you want to eat today?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          if (child != null) ...[
            const SizedBox.square(dimension: 20),
            child ?? Container(),
          ],
        ],
      ),
    );
  }
}
