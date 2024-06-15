import 'dart:async';

import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:mini_meow/game/limit_spawner_component.dart';
import 'package:mini_meow/game/target.dart';

class MeowGame extends FlameGame {
  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    final spawner = LimitedSpawnerComponent(
      maxCount: 1,
      area: Rectangle.fromLTWH(0, 0, size.x, size.y),
      factory: () => Target(),
    );

    add(spawner);
  }
}
