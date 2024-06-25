import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';

class UnoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UnoAppBar(
      {super.key,
      this.leading,
      this.automaticallyImplyLeading = false,
      this.title,
      this.actions,
      this.flexibleSpace,
      this.bottom,
      this.elevation,
      this.scrolledUnderElevation,
      this.shadowColor,
      this.surfaceTintColor,
      this.shape,
      this.backgroundColor,
      this.foregroundColor,
      this.appBarHeight = 60,
      this.centerTitle = false,
      this.iconColor,
      this.textColor,
      this.leadingWidth});

  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final double? scrolledUnderElevation;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double appBarHeight;
  final bool centerTitle;
  final Color? iconColor;
  final Color? textColor;
  final double? leadingWidth;

  factory UnoAppBar.create(
      {String? title,
      Color? propColor,
      required EasyPockerTheme theme,
      required BuildContext context}) {
    return UnoAppBar(
      leading: Navigator.canPop(context)
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            )
          : null,
      backgroundColor: theme.colorScheme.background,
      textColor: propColor,
      iconColor: propColor,
      // automaticallyImplyLeading: true,
      title: title != null
          ? Text(
              title,
              style: theme.materialData.textTheme.titleLarge,
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyPockerTheme;
    return AppBar(
      titleTextStyle: theme.materialData.textTheme.titleMedium?.copyWith(
        color: textColor,
        fontSize: 16,
      ),
      titleSpacing: 1,
      leading: leading,
      iconTheme: IconThemeData(color: iconColor ?? Colors.black),
      title: title,
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation ?? 0.0,
      scrolledUnderElevation: scrolledUnderElevation,
      shadowColor: shadowColor,
      shape: shape,
      backgroundColor: backgroundColor ?? Colors.white,
      foregroundColor: foregroundColor,
      centerTitle: centerTitle,
      leadingWidth: leadingWidth ?? 35.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
