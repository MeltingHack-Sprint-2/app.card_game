import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, EasyPockerTheme theme,
    {required String message, required Color backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message,
        style: theme.materialData.textTheme.bodyMedium
            ?.copyWith(color: theme.colorScheme.background)),
    behavior: SnackBarBehavior.floating,
    backgroundColor: backgroundColor,
  ));
}