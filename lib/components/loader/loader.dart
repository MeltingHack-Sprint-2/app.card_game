import 'package:card_game/theme/app_colors.dart';
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
          Text(
            label,
            style: theme.materialData.textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          CircularProgressIndicator(
            color: AppColors.mediumGrey.withOpacity(0.3),
            backgroundColor: AppColors.lightGrey.withOpacity(0.1),
          ),
        ],
      ),
    );
  }
}
