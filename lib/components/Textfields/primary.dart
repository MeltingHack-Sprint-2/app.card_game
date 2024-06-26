import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField(
      {super.key,
      this.onChanged,
      this.controller,
      this.errorText,
      this.labelText,
      this.hintText,
      this.initialValue,
      this.keyboardType,
      this.suffixIcon,
      this.prefixText,
      this.maxLine = 1,
      this.minLine = 1,
      this.contentPadding,
      this.readOnly = false,
      this.isDirty,
      this.textCapitalization,
      this.textInputAction,
      this.textInputFormatters});

  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? prefixText;
  final int? maxLine;
  final int? minLine;
  final EdgeInsetsGeometry? contentPadding;
  final bool readOnly;
  final bool? isDirty;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? textInputFormatters;

  @override
  Widget build(BuildContext context) {
    final theme = context.easyPockerTheme;
    return TextFormField(
      inputFormatters: textInputFormatters,
      initialValue: initialValue,
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: theme.colorScheme.onSecondary,
      style: theme.materialData.textTheme.bodyMedium
          ?.copyWith(color: theme.colorScheme.onSecondary, fontSize: 15),
      readOnly: readOnly,
      maxLines: maxLine,
      minLines: minLine,
      keyboardType: keyboardType,
      controller: controller,
      decoration: theme
          .primaryInputDecoration(
              themeData: theme.materialData,
              colorScheme: theme.colorScheme,
              isDirty: isDirty,
              hintText: hintText,
              errorText: errorText,
              labelText: labelText,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 14, right: 14),
                child: suffixIcon,
              ))
          .copyWith(
              alignLabelWithHint: true,
              contentPadding: contentPadding ??
                  const EdgeInsets.only(
                      left: 14, top: 16, right: 14, bottom: 14)),
      onChanged: onChanged,
    );
  }
}
