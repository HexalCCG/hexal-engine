import 'package:hexal_engine/effect/target/target.dart';

import 'effect.dart';

abstract class ITargetted {
  final Target target;
  final TargetResult targetResult;

  ITargetted(this.target, this.targetResult);

  Effect copyWithTarget(dynamic target);
}
