import 'dart:async';

import 'package:card_game/modules/home/screens/home_screen.dart';
import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routensame = '/splahScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _motionController;
  late Animation<double> _animation;

  @override
  void initState() {
    _motionController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      // lowerBound: 0.5,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _motionController, curve: Curves.easeInOut),
    );

    _timer = Timer(const Duration(milliseconds: 4000), _completeSplash);

    super.initState();
  }

  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _motionController.dispose();
    super.dispose();
  }

  _completeSplash() async {
    if (mounted) {
      Navigator.pushReplacementNamed(context, HomeScreen.routename);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.easyPockerTheme;
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Center(
        child: ScaleTransition(
            scale: _animation,
            child: Image.asset("assets/images/img_uno-logo.png")),
      ),
    );
  }
}
