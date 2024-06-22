import 'package:card_game/components/Textfields/primary.dart';
import 'package:card_game/components/buttons/button.dart';
import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';

class JoinGameDialogHelper {
  static Future<T?> showGameDialog<T>({required EasyPockerTheme theme, required BuildContext context, void Function()? onPressed}){
    final dialog = AlertDialog(
      backgroundColor: theme.colorScheme.background,
      insetPadding: const EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Join", style: theme.materialData.textTheme.displayLarge,),
          const SizedBox(height: 16,),
          Text("Enter Credentials to join game", style: theme.materialData.textTheme.bodyMedium,),
          const SizedBox(height: 24,),
          Text("Enter a name", style: theme.materialData.textTheme.bodyMedium,),
          PrimaryTextField(onChanged: (value){}, hintText: "John Doe",),
          const SizedBox(height: 16,),
          Text("Room", style: theme.materialData.textTheme.bodyMedium,),
          const SizedBox(height: 16,),
          PrimaryTextField(onChanged: (value){},),
          const SizedBox(height: 16,),
          PrimaryButton(text: "Join", onPressed: onPressed,),
        ],),
    );

    return showDialog(context: context, builder: (context) => Center(child: dialog));
  }
}