import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';

class EasyPokerTextButton extends StatelessWidget {
  const EasyPokerTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.fontSize,
    this.textColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final double? fontSize;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.easyPockerTheme;
    return InkWell(
      onTap: onPressed,
      child: Text(
        text,
        style: theme.materialData.textTheme.labelMedium?.copyWith(
            fontSize: fontSize ?? 15,
            color: textColor ?? theme.colorScheme.primary),
      ),
    );
  }
}
