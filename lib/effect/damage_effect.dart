import 'package:meta/meta.dart';

import '../cards/creature.dart';
import '../event/damage_creature_event.dart';
import '../event/damage_player_event.dart';
import '../event/request_target_event.dart';
import '../exceptions/event_exceptipn.dart';
import '../game_state/game_state.dart';
import '../game_state/player.dart';
import '../objects/card_object.dart';
import '../objects/game_object.dart';
import '../objects/player_object.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/modify_event_state_change.dart';
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
  final int targetIndex;

  const DamageEffect({
    @required Player controller,
    @required this.target,
    this.targetResult,
    this.targetIndex = 0,
    @required this.damage,
    bool resolved = false,
  }) : super(controller: controller, resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    if (targetResult == null) {
      return [
        AddEventStateChange(
            event: RequestTargetEvent(effect: this, target: target)),
      ];
    } else {
      if (targetResult.targets.isEmpty) {
        // If there are no targets, resolve this.
        return [ResolveEventStateChange(event: this)];
      } else {
        // If only one target is left, do it and resolve
        if (targetIndex == targetResult.targets.length - 1) {
          return [
            _generateStateChange(targetResult.targets[targetIndex]),
            ResolveEventStateChange(event: this),
          ];
        }
        // Otherwise do one target and increment
        else {
          return [
            _generateStateChange(targetResult.targets[targetIndex]),
            ModifyEventStateChange(event: this, newEvent: _copyIncremented),
          ];
        }
      }
    }
  }

  StateChange _generateStateChange(GameObject target) {
    if (target is CardObject && target is Creature) {
      return AddEventStateChange(
          event: DamageCreatureEvent(creature: target, damage: damage));
    } else if (target is PlayerObject) {
      return AddEventStateChange(
          event: DamagePlayerEvent(player: target.player, damage: damage));
    } else {
      throw const EventException('DamageEffect: Invalid target');
    }
  }

  DamageEffect get _copyIncremented => DamageEffect(
      controller: controller,
      target: target,
      targetResult: targetResult,
      targetIndex: targetIndex + 1,
      damage: damage,
      resolved: resolved);

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
  List<Object> get props => [target, targetResult, damage, resolved];
}
