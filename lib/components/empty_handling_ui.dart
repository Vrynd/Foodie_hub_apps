import 'package:flutter/material.dart';

class EmptyHandlingInterface extends StatelessWidget {
  final Widget? header;
  final IconData? iconHeader;
  final String title;
  final String description;
  final bool isLoading;

  const EmptyHandlingInterface({
    super.key,
    this.header,
    this.iconHeader,
    required this.title,
    required this.description,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            child: header!,
          ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 14, right: 14, bottom: 16),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            iconHeader,
                            size: 84,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox.square(dimension: 16),
                          Text(
                            title,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                          ),
                          const SizedBox.square(dimension: 8),
                          Text(
                            description,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
