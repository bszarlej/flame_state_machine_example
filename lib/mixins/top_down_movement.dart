import 'package:flame/components.dart';
import 'package:flutter/material.dart';

mixin TopDownMovement on PositionComponent {
  double moveSpeed = 100;
  final Vector2 velocity = Vector2.zero();

  AxisDirection facing = AxisDirection.down;

  void move(Vector2 direction) {
    if (direction.isZero()) {
      stop();
      return;
    }

    velocity
      ..setFrom(direction)
      ..normalize()
      ..scale(moveSpeed);

    _updateFacing(direction);
  }

  void stop() => velocity.setZero();

  void moveTo(Vector2 target) => move(target - position);

  void _updateFacing(Vector2 direction) {
    if (direction.x.abs() > direction.y.abs()) {
      facing = direction.x > 0
          ? AxisDirection.right
          : direction.x < 0
          ? AxisDirection.left
          : facing;
    } else {
      facing = direction.y > 0
          ? AxisDirection.down
          : direction.y < 0
          ? AxisDirection.up
          : facing;
    }
  }

  @override
  void update(double dt) {
    position += velocity * dt;
    super.update(dt);
  }

  bool get isMoving => !velocity.isZero();
}
