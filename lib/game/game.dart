import 'dart:async';

import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:mini_meow/game/limit_spawner_component.dart';
import 'package:mini_meow/game/target.dart';

class MeowGame extends FlameGame {
  late Rectangle area;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    area = Rectangle.fromLTWH(0, 0, size.x, size.y);

    await images.load('mouse.png');
    await FlameAudio.audioCache.loadAll([
      'mouse_background.mp3',
      'mouse_1.mp3',
    ]);

    await FlameAudio.loopLongAudio('mouse_background.mp3');

    final spawner = LimitedSpawnerComponent(
      maxCount: 1,
      area: area,
      factory: () => Target(),
    );

    add(spawner);
  }

  @override
  Color backgroundColor() {
    return Colors.white;
  }
}
