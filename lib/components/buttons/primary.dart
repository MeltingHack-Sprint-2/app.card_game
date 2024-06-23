import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.text,
      this.inProgress = false,
      this.height = 56,
      this.isEnabled = true,
      this.buttonStyle,
      this.onPressed,
      this.width,
      this.buttonRadius,
      this.fontSize});

  final String text;
  final bool inProgress;
  final double height;
  final bool isEnabled;
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
          style: theme.buttonStyle.copyWith(
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
