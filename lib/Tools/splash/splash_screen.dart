import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextLiquidFill(
          text: 'Kitap Köşkü',
          waveColor: Theme.of(context).colorScheme.primary,
          boxBackgroundColor: Theme.of(context).colorScheme.background,
          textAlign: TextAlign.center,
          textStyle: const TextStyle(
            fontSize: 40,
            fontFamily: "Dosis",
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
          boxHeight: 300,
        ),
      ),
    );
  }
}
