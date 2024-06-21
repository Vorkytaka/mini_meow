import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class LimitedSpawnerComponent extends Component {
  final int maxCount;
  final PositionComponent Function() factory;
  final Rectangle area;

  final Random _random;
  final List<PositionComponent> _spawnedComponents = [];

  LimitedSpawnerComponent({
    required this.maxCount,
    required this.factory,
    required this.area,
  }) : _random = Random();

  @override
  Future<void>? onLoad() async {
    _fillComponents();
    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Remove any component that is no longer on the game (deleted)
    _spawnedComponents.removeWhere((component) {
      return !component.isMounted || component.isRemoving;
    });

    _fillComponents();
  }

  void _fillComponents() {
    // Ensure there are always maxCount components
    while (_spawnedComponents.length < maxCount) {
      _spawnComponent();
    }
  }

  void _spawnComponent() {
    final component = factory();
    Vector2 pos = area.randomPoint(random: _random, within: false);

    if(pos.x == 0) {
      pos = Vector2(pos.x - 50, pos.y);
    } else if(pos.x == area.width) {
      pos = Vector2(pos.x + 50, pos.y);
    } else if(pos.y == 0) {
      pos = Vector2(pos.x, pos.y - 50);
    } else if(pos.y == area.height) {
      pos = Vector2(pos.x, pos.y + 50);
    }

    component.position = pos;
    _spawnedComponents.add(component);
    parent?.add(component);
  }
}
