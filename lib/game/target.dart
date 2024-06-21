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
  Target({
    required super.size,
  }) : super(
          anchor: Anchor.center,
        );

  final _moveController = EffectController(
    speed: 200,
    curve: Curves.easeInOut,
  );
  final _rotateController = EffectController(
    duration: 0.4,
  );

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

    final angleDiff = angleToTarget(position, moveTo, angle);

    add(
      RotateEffect.by(
        angleDiff,
        _rotateController,
      ),
    );
  }

  static double angleToTarget(Vector2 from, Vector2 to, double currentAngle) {
    // Вычисляем угол из точки from в точку to с использованием функции atan2.
    double targetAngle = atan2(to.y - from.y, to.x - from.x);

    // Находим разницу между целевым углом и текущим углом.
    double angleDifference = targetAngle - currentAngle;

    // Чтобы разница углов была в диапазоне [-π, π], мы нормализуем её.
    angleDifference = (angleDifference + pi) % (2 * pi) - pi;

    return angleDifference;
  }
}
