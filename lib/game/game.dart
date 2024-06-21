import 'dart:async';

import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_meow/game/limit_spawner_component.dart';
import 'package:mini_meow/game/target.dart';
import 'package:wakelock/wakelock.dart';

class MeowGame extends FlameGame {
  late Bgm audioBgm;
  late Rectangle area;

  static const double targetWidth = 200;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    Flame.device.fullScreen();
    Wakelock.enable();
    audioBgm = Bgm(audioCache: FlameAudio.audioCache);
    FlameAudio.bgm.initialize();

    area = Rectangle.fromLTWH(0, 0, size.x, size.y);

    final targetSprite = await images.load('mouse.png');
    final targetAspectRatio = targetSprite.height / targetSprite.width;
    final targetHeight = targetWidth * targetAspectRatio;
    final targetSize = Vector2(targetWidth, targetHeight);

    await FlameAudio.audioCache.loadAll([
      'mouse_background.mp3',
      'mouse_1.mp3',
    ]);

    await audioBgm.play('mouse_background.mp3');

    final spawner = LimitedSpawnerComponent(
      maxCount: 1,
      area: area,
      targetSize: targetSize,
      factory: () => Target(
        size: targetSize,
      ),
    );

    add(spawner);
  }

  @override
  void onDispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Wakelock.disable();
    audioBgm.dispose();
  }

  @override
  Color backgroundColor() {
    return Colors.white;
  }
}
