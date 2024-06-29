import 'dart:ui';
import 'package:card_game/components/buttons/text_button.dart';
import 'package:card_game/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class WinScreen extends StatefulWidget {
  static const routename = "/winScreen";
  final String winnerName;
  final String currentPlayer;
  const WinScreen({
    super.key,
    required this.winnerName,
    required this.currentPlayer,
  }); // Made constructor const

  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    _confettiController.play();
    _confettiController.addListener(() {
      if (_confettiController.state == ConfettiControllerState.stopped) {
        _showPopup();
      }
    });
  }

  void _showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final theme = context.easyPockerTheme;
        final bool isWinner = widget.currentPlayer == widget.winnerName;
        return Dialog(
          backgroundColor:
              Colors.transparent, // Make dialog background transparent
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0), // Rounded corners
            child: BackdropFilter(
              filter:
                  ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Apply blur effect
              child: Container(
                decoration: BoxDecoration(
                  color:
                      Colors.white.withOpacity(0.7), // Semi-transparent white
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Use minimum space
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Text(isWinner ? 'Congratulations🎉!' : "Nice Game",
                        style: theme.materialData.textTheme.bodyLarge),
                    const SizedBox(height: 20),
                    Text(
                        isWinner
                            ? 'You are the winner!'
                            : '${widget.winnerName} won!',
                        style: theme.materialData.textTheme.bodyMedium),
                    const SizedBox(height: 20),
                    EasyPokerTextButton(
                      text: "Go To Home",
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const imgSrc = 'assets/cards/win.svg';
    return Scaffold(
        body: GestureDetector(
      onTap: _showPopup,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            imgSrc,
            width: 300,
            height: 400,
            fit: BoxFit.cover, // This ensures the SVG covers the container area
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: -50 * (math.pi / 180), // Convert degrees to radians
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Stack(
                    children: <Widget>[
                      // Shadow layer
                      Transform.translate(
                        offset: const Offset(-5,
                            5), // Adjust the offset to control the depth effect
                        child: Text(
                          'Winner!\n${widget.winnerName}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            height: 0.9,
                            color:
                                Colors.black.withOpacity(0.8), // Shadow color
                          ),
                        ),
                      ),
                      // Top layer text
                      Text(
                        'Winner!\n${widget.winnerName}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                          height: 0.9,
                          color: Colors.yellow, // Text color
                          shadows: [
                            Shadow(
                                offset: Offset(-10,
                                    10), // Increase offset to make the shadow thicker
                                color: Colors
                                    .black // Optionally adjust color opacity here too
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
