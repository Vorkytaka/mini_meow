import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';

class LimitedSpawnerComponent extends Component {
  final int maxCount;
  final PositionComponent Function() factory;
  final Shape area;

  final Random _random;
  final List<PositionComponent> _spawnedComponents = [];

  LimitedSpawnerComponent({
    required this.maxCount,
    required this.factory,
    required this.area,
  }) : _random = Random();

  @override
  Future<void>? onLoad() async {
    for (int i = 0; i < maxCount; i++) {
      _spawnComponent();
    }
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Remove any component that is no longer on the game (deleted)
    _spawnedComponents.removeWhere(
      (component) => component.isMounted == false || component.isRemoving,
    );

    // Ensure there are always maxCount components
    while (_spawnedComponents.length < maxCount) {
      _spawnComponent();
    }
  }

  void _spawnComponent() {
    final component = factory();
    component.position = area.randomPoint(random: _random);
    _spawnedComponents.add(component);
    parent?.add(component);
  }
}
