import 'creature.dart';

/// Permanent card with stats that can attack and block attacks.
mixin Ready on Creature {
  /// Allowed to attack creatures?
  @override
  bool get canAttack => !exhausted;
}
