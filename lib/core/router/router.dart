import 'package:card_game/core/router/routes.dart';
import 'package:card_game/modules/home/screens/home_screen.dart';
import 'package:card_game/modules/home/screens/host/host_screen.dart';
import 'package:card_game/modules/home/screens/join/join_screen.dart';
import 'package:card_game/modules/play/screens/play_screen.dart';
import 'package:card_game/modules/win/screens/win_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.playScreen:
        return CupertinoPageRoute(
            builder: (_) => PlayScreen(
                  config: args!["config"],
                  currentPlayer: args["player"],
                ));
      case Routes.hostScreen:
        return CupertinoPageRoute(
          builder: (_) => const HostScreen(),
        );
      case Routes.joinScreen:
        return CupertinoPageRoute(builder: (_) => const JoinScreen());
      case Routes.winScreen:
        return MaterialPageRoute(
            builder: (_) => WinScreen(
                  winnerName: args!["winner"],
                ));
      default:
        return MaterialPageRoute<void>(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No Route"),
            ),
          ),
        );
    }
  }
}
