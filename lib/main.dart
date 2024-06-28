import 'package:card_game/core/config/app_config.dart';
import 'package:card_game/core/config/app_instance.dart';
import 'package:card_game/core/router/router.dart';
import 'package:card_game/modules/home/screens/home_screen.dart';
import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() async {
  const env = String.fromEnvironment("ENVIRONMENT");
  // Ensure widgets binding is initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();
  // Set preferred device orientations to portrait mode (both up and down).
  runApp(
    EasyPoker(
      appConfig: await AppConfig.forEnvironment(env: env),
    ),
  );
}

class EasyPoker extends StatelessWidget {
  final AppConfig appConfig;
  const EasyPoker({super.key, required this.appConfig});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppInstance().setConfig(appConfig);
    return const AppTheme(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Easy Poker',
        home: HomeScreen(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
