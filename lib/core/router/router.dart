import 'package:card_game/core/router/routes.dart';
import 'package:card_game/modules/home/screens/home_screen.dart';
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
        return CupertinoPageRoute(builder: (_) => const PlayScreen());
      case Routes.winScreen:
        return MaterialPageRoute(
            builder: (_) => const WinScreen(
                  winnerName: 'Moriz',
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
