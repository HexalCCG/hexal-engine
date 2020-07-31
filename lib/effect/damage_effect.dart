import 'package:hexal_engine/game_state/player.dart';
import 'package:meta/meta.dart';

import '../cards/mi_creature.dart';
import '../event/damage_creature_event.dart';
import '../event/damage_player_event.dart';
import '../event/request_target_event.dart';
import '../exceptions/event_exceptipn.dart';
import '../game_state/game_state.dart';
import '../objects/card_object.dart';
import '../objects/player_object.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/resolve_event_state_change.dart';
import '../state_change/state_change.dart';
import 'effect.dart';
import 'i_targetted.dart';
import 'target/target.dart';

class DamageEffect extends Effect implements ITargetted {
  @override
  final Target target;
  @override
  final TargetResult targetResult;

  final int damage;

  const DamageEffect({
    @required Player controller,
    @required this.target,
    this.targetResult,
    @required this.damage,
    bool resolved = false,
  }) : super(controller: controller, resolved: resolved);

  @override
  DamageEffect copyWithTarget(targetResult) => DamageEffect(
      controller: controller,
      target: target,
      targetResult: targetResult,
      damage: damage,
      resolved: resolved);

  @override
  DamageEffect get copyResolved => DamageEffect(
      controller: controller,
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
