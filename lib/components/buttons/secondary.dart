import 'package:card_game/theme/app_colors.dart';
import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {super.key,
      required this.text,
      this.inProgress = false,
      this.height = 56,
      this.isEnabled = true,
      this.buttonStyle,
      this.onPressed,
      this.width,
      this.buttonRadius,
      this.backgroundColor,
      this.fontSize});

  final String text;
  final bool inProgress;
  final double height;
  final bool isEnabled;
  final Color? backgroundColor;
  final ButtonStyle? buttonStyle;
  final VoidCallback? onPressed;
  final double? width;
  final double? buttonRadius;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final theme = context.easyPockerTheme;
    return SizedBox(
        height: height,
        width: width,
        child: TextButton(
          onPressed: onPressed,
          style: theme.secondaryButton.copyWith(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => states.contains(MaterialState.disabled)
                    ? backgroundColor ?? AppColors.lightGrey
                    : backgroundColor ?? AppColors.lightGrey,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius ?? 10),
              ))),
          child: inProgress
              ? Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.colorScheme.surface,
                    ),
                  ),
                )
              : Text(
                  text,
                  style: theme.materialData.textTheme.labelMedium?.copyWith(
                      color: Colors.black, fontSize: fontSize, height: 1),
                ),
        ));
  }
}
