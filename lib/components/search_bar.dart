import 'package:flutter/material.dart';

class SearchBarHeader extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onSearch;

  const SearchBarHeader({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      leading: IconButton.filled(
        color: Theme.of(context).colorScheme.secondary,
        icon: Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 26,
        ),
        onPressed: () => onSearch(controller.text.trim()),
      ),
      onSubmitted: onSearch,

      elevation: const WidgetStatePropertyAll(0),
      hintText: "Search",
      hintStyle: WidgetStatePropertyAll(
        Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),

      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      backgroundColor: WidgetStatePropertyAll(
        Theme.of(context).colorScheme.surfaceContainerLowest,
      ),

      side: WidgetStatePropertyAll(
        BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
    );
  }
}
