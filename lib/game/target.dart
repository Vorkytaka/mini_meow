import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Target extends PositionComponent with HasGameReference, TapCallbacks {
  Target()
      : super(
          anchor: Anchor.center,
          size: Vector2(50, 50),
        );

  final _paint = Paint()..color = Colors.red;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _paint);
  }


  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);

    removeFromParent();
  }
}
