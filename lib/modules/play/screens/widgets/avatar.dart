import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String name;

  const Avatar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final theme = context.easyPockerTheme;
    return CircleAvatar(
      child: Text(
        name[0].toUpperCase(),
        style: theme.materialData.textTheme.titleSmall,
      ),
    );
  }
}
