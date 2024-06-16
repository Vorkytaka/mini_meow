import 'dart:async';

import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mini_meow/game/limit_spawner_component.dart';
import 'package:mini_meow/game/target.dart';

class MeowGame extends FlameGame {
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    await images.load('mouse.png');

    final spawner = LimitedSpawnerComponent(
      maxCount: 3,
      area: Rectangle.fromLTWH(0, 0, size.x, size.y),
      factory: () => Target(),
    );

    add(spawner);
  }

  @override
  Color backgroundColor() {
    return Colors.white;
  }
}
