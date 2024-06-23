import 'package:card_game/components/Textfields/primary.dart';
import 'package:card_game/components/buttons/button.dart';
import 'package:card_game/theme/app_colors.dart';
import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HostGameDialogHelper {
  static Future<T?> showGameDialog<T>({required EasyPockerTheme theme, required BuildContext context, void Function()? onPressed}){
final dialog = AlertDialog(
backgroundColor: theme.colorScheme.background,
insetPadding: const EdgeInsets.all(0),
content: Column(
  mainAxisSize: MainAxisSize.min,
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Text("Host", style: theme.materialData.textTheme.displayLarge,),
    const SizedBox(height: 16,),
    Text("Enter Credentials to host game", style: theme.materialData.textTheme.bodyMedium,),
    const SizedBox(height: 24,),
    PrimaryTextField(onChanged: (value){}, hintText: "John Doe",),
    const SizedBox(height: 16,),
    Text("Room", style: theme.materialData.textTheme.bodyMedium,),
    const SizedBox(height: 16,),
    _codeDisplay(code: "XYZWE_D", theme: theme),
    const SizedBox(height: 16,),
    Text("Hand Size", style: theme.materialData.textTheme.bodyMedium,),
    const SizedBox(height: 16,),
    PrimaryTextField(onChanged: (value){},),
    const SizedBox(height: 16,),
    PrimaryButton(text: "Host", onPressed: onPressed,),
],),
);

    return showDialog(context: context, builder: (context) => Center(child: dialog));
  }
}


Widget _codeDisplay({required String code, required EasyPockerTheme theme}){
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(color: AppColors.mediumGrey.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),

    child: Text(code, style: theme.materialData.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),),
  );
}