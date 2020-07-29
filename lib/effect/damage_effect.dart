import 'package:hexal_engine/effect/target/target.dart';
import 'package:hexal_engine/event/request_target_event.dart';
import 'package:hexal_engine/state_change/resolve_event_state_change.dart';
import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/state_change.dart';
import 'effect.dart';
import 'i_targetted.dart';

class DamageEffect extends Effect implements ITargetted {
  @override
  final Target target;
  @override
  final TargetResult targetResult;

  final int damage;

  const DamageEffect({
    @required this.target,
    this.targetResult,
    @required this.damage,
    bool resolved = false,
  }) : super(resolved: resolved);

  @override
  DamageEffect copyWithTarget(target) => DamageEffect(
      target: target,
      targetResult: targetResult,
      damage: damage,
      resolved: resolved);

  @override
  DamageEffect get copyResolved => DamageEffect(
      target: target,
      targetResult: targetResult,
      damage: damage,
      resolved: true);

  @override
  List<StateChange> apply(GameState state) {
    if (targetResult == null) {
      return [
        AddEventStateChange(
            event: RequestTargetEvent(effect: this, target: target)),
      ];
    } else {
      return [
        AddEventStateChange(
            event: DamageEffect(target: target, damage: damage)),
        ResolveEventStateChange(event: this),
      ];
    }
  }

  @override
  List<Object> get props => [target, damage, resolved];
}
