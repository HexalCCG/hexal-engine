import 'package:hexal_engine/exceptions/event_exceptipn.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/objects/player_object.dart';

import '../cards/mi_creature.dart';
import 'target/target.dart';
import '../event/damage_creature_event.dart';
import '../event/damage_player_event.dart';
import '../event/request_target_event.dart';
import '../state_change/resolve_event_state_change.dart';
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
  DamageEffect copyWithTarget(targetResult) => DamageEffect(
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
        ...targetResult.targets.map((target) {
          if (target is CardObject && target is ICreature) {
            return AddEventStateChange(
                event: DamageCreatureEvent(creature: target, damage: damage));
          } else if (target is PlayerObject) {
            return AddEventStateChange(
                event:
                    DamagePlayerEvent(player: target.player, damage: damage));
          } else {
            throw const EventException('DamageEffect: Invalid target');
          }
        }),
        ResolveEventStateChange(event: this),
      ];
    }
  }

  @override
  List<Object> get props => [target, damage, resolved];
}
