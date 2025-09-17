import 'package:flutter/material.dart';

class AppBarTemplate extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget? leading;
  final bool? centerTitle;
  final List<Widget>? action;
  const AppBarTemplate({
    super.key,
    this.leading,
    this.centerTitle,
    required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 1.0,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      shadowColor: Theme.of(context).colorScheme.surfaceContainer,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      leading: leading,
      actions: action,
      centerTitle: centerTitle,
      title: title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
