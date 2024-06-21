import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/widgets.dart';
import 'package:mini_meow/game/game.dart';

class HudComponent extends PositionComponent with HasGameReference<MeowGame> {
  TimerComponent? _exitTimer;

  @override
  FutureOr<void> onLoad() async {
    add(ExitButton(
      onDown: () {
        _exitTimer = TimerComponent(
          period: 5,
          repeat: false,
          autoStart: true,
          removeOnFinish: true,
          onTick: () {
            Navigator.of(game.buildContext!).pop();
          },
        );
        add(_exitTimer!);
        game.overlays.add('exit_hint');
      },
      onUp: () {
        final timer = _exitTimer;
        if (timer != null && timer.timer.isRunning()) {
          timer.timer.stop();
          remove(timer);
          _exitTimer = null;
          game.overlays.remove('exit_hint');
        }
      },
    ));
  }
}

class ExitButton extends TextComponent with TapCallbacks {
  final VoidCallback onDown;
  final VoidCallback onUp;

  ExitButton({
    required this.onDown,
    required this.onUp,
  }) : super(
          text: "EXIT",
          size: Vector2(100, 100),
          position: Vector2(50 , 50),
        );

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    onDown();
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    onUp();
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    onUp();
  }
}
