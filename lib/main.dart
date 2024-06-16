import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mini_meow/game/game.dart';

void main() {
  runApp(
    GameWidget(
      game: MeowGame(),
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
