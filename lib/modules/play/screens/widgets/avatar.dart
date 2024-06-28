import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String name;
  final double? radius;

  const Avatar({super.key, required this.name, this.radius});

  @override
  Widget build(BuildContext context) {
    final theme = context.easyPockerTheme;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: theme.colorScheme.primary,
        child: Text(
          name[0].toUpperCase(),
          style: theme.materialData.textTheme.titleSmall,
        ),
      ),
    );
  }
}
