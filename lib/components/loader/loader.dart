import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final String label;

  const Loader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = context.easyPockerTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: theme.colorScheme.secondary,
            backgroundColor: theme.colorScheme.secondary.withOpacity(0.3),
          ),
          const SizedBox(height: 20),
          Text(label),
        ],
      ),
    );
  }
}
