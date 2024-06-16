import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/animation.dart';
import 'package:mini_meow/game/game.dart';

class Target extends SpriteComponent
    with HasGameReference<MeowGame>, TapCallbacks {
  Target()
      : super(
          anchor: Anchor.center,
          size: Vector2(47, 99.5),
        );

  final _controller = EffectController(
    speed: 100,
    curve: Curves.easeInOut,
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

    removeFromParent();
  }

  void _moveTo() {
    _controller.setToStart();
    final moveTo = game.area.randomPoint();
    add(
      MoveToEffect(
        moveTo,
        _controller,
        onComplete: _moveTo,
      ),
    );
  }
}
