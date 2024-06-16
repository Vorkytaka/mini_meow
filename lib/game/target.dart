import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/animation.dart';
import 'package:mini_meow/game/game.dart';

class Target extends SpriteComponent
    with HasGameReference<MeowGame>, TapCallbacks {
  Target()
      : super(
          anchor: Anchor.center,
          size: Vector2(99.5, 47),
          // angle: 1,
        );

  final _moveController = EffectController(
    speed: 100,
    curve: Curves.easeInOut,
  );
  final _rotateController = EffectController(duration: 1);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    sprite = Sprite(game.images.fromCache('mouse.png'));

    _moveTo();
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);

    FlameAudio.play('mouse_1.mp3');
    removeFromParent();
  }

  void _moveTo() {
    _moveController.setToStart();
    _rotateController.setToStart();
    final moveTo = game.area.randomPoint();
    add(
      MoveToEffect(
        moveTo,
        _moveController,
        onComplete: _moveTo,
      ),
    );

    // TODO: Подумой
    // Calculate the angle
    final deltaX = moveTo.x - position.x;
    final deltaY = moveTo.y - position.y;
    final angle = atan2(deltaY, deltaX);

    add(
      RotateEffect.to(
        angle,
        _rotateController,
      ),
    );
  }
}
