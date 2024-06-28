import 'package:card_game/components/buttons/button.dart';
import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameAlert {
  static Future<T?> showAlert<T>({
    required BuildContext context,
    required EasyPockerTheme theme,
    required void Function()? onTapYes,
    required void Function()? onTapNo,
  }) {
    final dialog = AlertDialog(
      backgroundColor: theme.colorScheme.background,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          const Icon(Icons.exit_to_app_outlined),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Are you sure you want to exit the game?",
            style: theme.materialData.textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).width * 0.1,
                width: MediaQuery.sizeOf(context).width * 0.3,
                child: PrimaryButton(
                  text: "Yes",
                  onPressed: onTapYes,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).width * 0.1,
                width: MediaQuery.sizeOf(context).width * 0.3,
                child: SecondaryButton(
                  text: "No",
                  onPressed: onTapNo,
                ),
              ),
            ],
          )
        ],
      ),
    );

    return showDialog(
        context: context,
        builder: (context) => Center(
              child: dialog,
            ));
  }
}
