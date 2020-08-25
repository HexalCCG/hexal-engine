import '../models/enums/player.dart';
import 'effect.dart';
import 'i_targeted.dart';
import 'target/target.dart';

/// Effect that requests a target.
abstract class TargetedEffect extends Effect implements ITargeted {
  final Target target;
  final TargetResult targetResult;

  /// Effect that requests a target.
  const TargetedEffect(
      {required Player controller,
      required this.target,
      required this.targetResult,
      bool resolved = false})
      : super(controller: controller, resolved: resolved);
}
