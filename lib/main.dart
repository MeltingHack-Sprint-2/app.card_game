import 'package:card_game/core/config/app_config.dart';
import 'package:card_game/core/config/app_instance.dart';
import 'package:card_game/core/router/router.dart';
import 'package:card_game/modules/home/screens/splash/splash_screen.dart';
import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  const env = String.fromEnvironment("ENVIRONMENT");
  // Ensure widgets binding is initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();
  // Set preferred device orientations to portrait mode (both up and down).

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) async {
    runApp(UnoCardGame(
      appConfig: await AppConfig.forEnvironment(env: env),
    ));
  });
}

class UnoCardGame extends StatelessWidget {
  final AppConfig appConfig;
  const UnoCardGame({super.key, required this.appConfig});

  @override
  Widget build(BuildContext context) {
    AppInstance().setConfig(appConfig);
    return const AppTheme(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Uno Card Game',
        home: SplashScreen(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
