import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

class Target extends SpriteComponent with HasGameReference, TapCallbacks {
  Target()
      : super(
          anchor: Anchor.center,
          size: Vector2(47, 99.5),
        );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    sprite = Sprite(game.images.fromCache('mouse.png'));
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);

    removeFromParent();
  }
}
