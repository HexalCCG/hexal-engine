import 'effect.dart';
import 'target/target.dart';

/// Defines an effect as requiring a target.
abstract class ITargeted {
  /// Target template to fill.
  final Target target;

  /// Result of requesting a target from the player.
  final TargetResult targetResult;

  /// Defines an effect as requiring a target.
  ITargeted(this.target, this.targetResult);

  /// Copies this effect with [targetResult] set to this.
  Effect copyWithTarget(TargetResult target);
}
