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
    component.position = area.randomPoint(random: _random);
    _spawnedComponents.add(component);
    parent?.add(component);
  }
}
