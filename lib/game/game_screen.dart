import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GameWidget(
        game: MeowGame(),
        overlayBuilderMap: {
          'exit_hint': (context, game) {
            final theme = Theme.of(context);

            return Center(
              child: SizedBox(
                height: 100,
                child: Material(
                  color: Colors.blue.shade100.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      'Hold 5 sec for exit',
                      style: theme.textTheme.displayLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
        backgroundBuilder: (context) {
          return const SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background/woods.jpg'),
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
