import 'package:card_game/components/alerts/host_game_dialog.dart';
import 'package:card_game/components/alerts/join_game_dialog.dart';
import 'package:card_game/components/buttons/button.dart';
import 'package:card_game/modules/play/screens/play_screen.dart';
import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';

// Host or join game

class HomeScreen extends StatelessWidget {
  static const routename = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.easyPockerTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/images/img_uno-logo.png"),
              const SizedBox(height: 20,),
              PrimaryButton(
                text: "HOST",
                onPressed: () {
                  HostGameDialogHelper.showGameDialog(
                      theme: theme, context: context);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              SecondaryButton(
                text: "JOIN",
                onPressed: () {
                  JoinGameDialogHelper.showGameDialog(
                      theme: theme,
                      context: context,
                      onPressed: () =>
                          Navigator.pushNamed(context, PlayScreen.routename));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
