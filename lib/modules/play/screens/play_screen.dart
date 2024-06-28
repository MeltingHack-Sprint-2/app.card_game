import 'package:card_game/components/alerts/game_alert.dart';
import 'package:card_game/components/alerts/snackbar.dart';
import 'package:card_game/components/appbar/app_bar.dart';
import 'package:card_game/components/buttons/button.dart';
import 'package:card_game/components/buttons/text_button.dart';
import 'package:card_game/components/loader/loader.dart';
import 'package:card_game/core/router/routes.dart';
import 'package:card_game/modules/play/api/models/game_config.dart';
import 'package:card_game/modules/play/bloc/game_bloc.dart';
import 'package:card_game/modules/play/screens/widgets/avatar.dart';
import 'package:card_game/modules/play/screens/widgets/game.dart';
import 'package:card_game/modules/win/screens/win_screen.dart';
import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayScreen extends StatelessWidget {
  static const routename = "/playScreen";
  final GameConfig config;
  final String currentPlayer;

  const PlayScreen(
      {super.key, required this.config, required this.currentPlayer});

  @override
  Widget build(BuildContext context) {
    final theme = context.easyPockerTheme;
    return BlocProvider(
      create: (context) =>
          GameBloc(config, currentPlayer), // Add config and current player
      child: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          if (state is PlayerLeaveState) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.home,
              (route) => false,
            );
          } else if (state is GameWonState) {
            Navigator.pushNamed(context, WinScreen.routename, arguments: {
              "winner": state.winner,
            });
          }
        },
        builder: (context, state) {
          if (!state.started) {
            return Scaffold(
                backgroundColor: theme.colorScheme.background,
                appBar: UnoAppBar.game(
                    theme: theme,
                    onPressed: () {
                      GameAlert.showAlert(
                          context: context,
                          theme: theme,
                          onTapYes: () {
                            context.read<GameBloc>().add(PlayerLeave());
                          },
                          onTapNo: () {
                            Navigator.pop(context);
                          });
                    }),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        children: state.players
                            .map((e) => Avatar(
                                  name: e.name,
                                  radius: 30,
                                ))
                            .toList(),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Loader(
                          label: state.players.length > 1
                              ? "Waiting for the game to start"
                              : "Waiting for other players..."),
                      const SizedBox(
                        height: 16,
                      ),
                      PrimaryButton(
                        text: "Start Game",
                        onPressed: state.players.length > 1
                            ? () =>
                                context.read<GameBloc>().add(HandleGameStart())
                            : null,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      EasyPokerTextButton(
                        text: "Copy Room",
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: config.room));
                          showSnackBar(
                            context,
                            theme,
                            message: "Copied to the clipboard ${config.room}",
                            backgroundColor: Colors.green,
                          );
                        },
                      ),
                    ],
                  ),
                ));
          }
          return Scaffold(
            backgroundColor: theme.colorScheme.background,
            appBar: UnoAppBar.game(
                theme: theme,
                onPressed: () {
                  GameAlert.showAlert(
                      context: context,
                      theme: theme,
                      onTapYes: () {
                        context.read<GameBloc>().add(PlayerLeave());
                      },
                      onTapNo: () {
                        Navigator.pop(context);
                      });
                }),
            body: Game(state: state),
          );
        },
      ),
    );
  }
}
