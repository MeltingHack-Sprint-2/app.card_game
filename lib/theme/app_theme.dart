import 'package:card_game/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTheme extends StatelessWidget {
  // Provides the AppTheme to whatever widget it is wrapped around
  const AppTheme({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final themeData = EasyPockerTheme.standard;
    return Provider.value(value: themeData, child: child);
  }
}

// Provides a consistent theme accross the application
class EasyPockerTheme {
  // Singleton instance to ensure a single theme object throughout the app
  static final EasyPockerTheme _easyPockerTheme = EasyPockerTheme._privateConstructor();

  // Constructor to return the singleton instance
  static EasyPockerTheme get standard => _easyPockerTheme;
  // Private constructor to prevent direct instantiation
  EasyPockerTheme._privateConstructor();
  // Exposes the color scheme of the current scheme
  ColorScheme get colorScheme => materialData.colorScheme;
  // Provides the full theme data object for more complex needs
  ThemeData get materialData {
    return ThemeData(
      // Customize appBar exxperience
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
      ),
      // Define the overall color scheme
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.darkBlue,
        onPrimary: AppColors.white,
        secondary: AppColors.deepBrown,
        onSecondary: Color.fromRGBO(30, 30, 30, 1),
        error: AppColors.red,
        onError: Color.fromRGBO(235, 87, 87, 0.5),
        background: AppColors.white,
        onBackground: Color.fromRGBO(240, 240, 240, 1),
        surface: Color.fromRGBO(248, 251, 255, 1),
        onSurface: Color.fromRGBO(248, 248, 248, 1),
      ),
      // Define the various text styles used through the app
      textTheme: const TextTheme(
        // TEXT STYLES
        displayLarge: TextStyle(
          fontFamily: 'Playfair Display',
          fontSize: 26.0,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Playfair Display',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Playfair Display',
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        titleSmall: TextStyle(
          fontFamily: 'Playfair Display',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: ElementColors.title,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Playfair Display',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: ElementColors.title,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Playfair Display',
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: ElementColors.title,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Open Sans',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Open Sans',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Open Sans',
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: AppColors.black,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Open Sans',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Open Sans',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Open Sans',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
      ),
    );
  }

  // Define a consistent button styles for primary button
  ButtonStyle get buttonStyle {
    return ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith((states) =>
          states.contains(MaterialState.disabled)
              ? colorScheme.primary.withOpacity(0.4)
              : materialData.colorScheme.primaryContainer),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.disabled)
            ? colorScheme.primary.withOpacity(0.4)
            : colorScheme.primary,
      ),
      textStyle: MaterialStateProperty.resolveWith(
        (state) => state.contains(MaterialState.disabled)
            ? materialData.textTheme.labelLarge?.copyWith(
                color: Colors.white,
              )
            : materialData.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      iconColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.disabled)
            ? Colors.white
            : Colors.white,
      ),
    );
  }

  // Define a consistent button styles for primary button
  ButtonStyle get secondaryButton {
    return ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.disabled)
            ? Colors.transparent
            // ? materialData.colorScheme.primary.withOpacity(0.5)
            : materialData.colorScheme.primary,
      ),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.disabled)
            ? AppColors.lighterGrey
            : AppColors.lightGrey,
      ),
      textStyle:
          MaterialStateProperty.all(materialData.textTheme.labelLarge?.copyWith(
        color: colorScheme.secondary,
      )),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          // side: BorderSide(
          //   color: colorScheme.primary,
          //   width: 1.5,
          // ),
        ),
      ),
    );
  }

  // Input Decorations
  TextStyle? _labelStyle({
    required ThemeData themeData,
    required ColorScheme colorScheme,
    required bool isError,
    Color? textColor,
  }) {
    return isError
        ? themeData.textTheme.bodyLarge
            ?.copyWith(color: colorScheme.error, fontSize: 12, wordSpacing: 1.2)
        : themeData.textTheme.bodyLarge?.copyWith(
            color: textColor ??
                const Color.fromRGBO(27, 29, 33, 1).withOpacity(0.6),
            fontSize: 13);
  }

  // Utility method to create input decoration styles with various options
  InputDecoration primaryInputDecoration({
    String? hintText,
    String? labelText,
    String? errorText,
    required ThemeData themeData,
    required ColorScheme colorScheme,
    bool? isDirty,
    Widget? suffixIcon,
    Widget? suffix,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      focusColor: colorScheme.primary,
      contentPadding: const EdgeInsets.fromLTRB(24.0, 19.0, 14.0, 20.0),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.lightGrey,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: AppColors.lightGrey,
          width: 1.4,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: colorScheme.error,
          width: 1.4,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          width: 1.4,
          color: colorScheme.error,
        ),
      ),
      labelText: labelText,
      hintText: hintText,
      hintStyle: themeData.textTheme.bodyMedium?.copyWith(
        color: const Color.fromRGBO(114, 114, 114, 1).withOpacity(0.3),
        fontSize: 14,
      ),
      labelStyle: _labelStyle(
        themeData: themeData,
        colorScheme: colorScheme,
        isError: errorText != null,
        textColor: isDirty == true
            ? colorScheme.primary.withOpacity(0.5)
            : colorScheme.primary,
      ),
      errorText: errorText,
      errorStyle: _labelStyle(
        themeData: themeData,
        colorScheme: colorScheme,
        isError: errorText != null,
      ),
      suffixIcon: suffixIcon,
      suffix: suffix,
    );
  }

  InputDecoration secondaryInputDecoration({
    String? labelText,
    String? errorText,
    ThemeData? themeData,
    required ColorScheme colorScheme,
    bool? isDirty,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: AppColors.lightGrey,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
        borderSide: BorderSide(
          color: AppColors.lightGrey,
          width: 1,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: colorScheme.error,
        ),
      ),
      labelText: labelText,
      suffixIcon: suffixIcon,
    );
  }

  InputDecoration lineInputDecoration({
    String? hintText,
    required ColorScheme colorScheme,
    String? labelText,
    String? errorText,
    ThemeData? themeData,
    bool? isDirty,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      focusColor: Colors.transparent,
      contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.mediumGrey.withOpacity(0.2),
        ),
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
        color: AppColors.mediumGrey.withOpacity(0.2),
      )),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.mediumGrey,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: colorScheme.error,
        ),
      ),
      labelText: labelText,
      hintText: hintText,
      suffixIcon: suffixIcon,
    );
  }

  //Search Input Decoration
  InputDecoration searchInputDecoration({
    String? hintText,
    required String leadingIcon,
    required ThemeData themeData,
    bool? isDirty,
    bool? isFocused = false,
    Color? fillColor,
    double? borderRadius,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: colorScheme.secondary.withOpacity(0.1),
          width: 1.4,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          width: 1.4,
          color: colorScheme.error,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: colorScheme.primary.withOpacity(0.1),
          width: 1.4,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: colorScheme.error,
          width: 1.4,
        ),
      ),
      prefixIcon: const Padding(
          padding: EdgeInsets.all(15.0), child: Icon(Icons.search)),
      hintText: hintText,
      hintStyle: themeData.textTheme.bodyMedium?.copyWith(
        color: const Color.fromRGBO(186, 186, 186, 1),
      ),
    );
  }

  /// Chat Input Decoration
  InputDecoration chatInputDecoration({
    Widget? suffixIcon,
    String? hintText,
  }) {
    return InputDecoration(
      hintText: hintText,
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          width: 0.1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: colorScheme.primaryContainer, width: 1.0),
      ),
      fillColor: const Color.fromRGBO(248, 251, 255, 1),
      filled: true,
      suffixIcon: suffixIcon,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
    );
  }
}

extension BuildContextExtension on BuildContext {
  EasyPockerTheme get easyPockerTheme {
    return watch<EasyPockerTheme>();
  }
}
