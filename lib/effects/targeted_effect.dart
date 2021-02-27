import '../models/enums/player.dart';
import 'effect.dart';
import 'target/target.dart';

/// Defines an effect as requiring a target.
mixin TargetedEffect on Effect {
  /// Player who provides this target.
  Player get controller;

  /// Target template to fill.
  Target get target;

  /// If this has had its target set.
  bool get targetFilled;

  /// Result of requesting a target from the player.
  List<int> get targets;

  /// Copies this effect with [targets] set to this.
  TargetedEffect copyFilled(List<int> targets);
}
