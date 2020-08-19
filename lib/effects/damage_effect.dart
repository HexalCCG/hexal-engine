import '../cards/creature.dart';
import '../events/damage_creature_event.dart';
import '../events/damage_player_event.dart';
import '../events/request_target_event.dart';
import '../exceptions/event_exception.dart';
import '../models/card_object.dart';
import '../models/game_object.dart';
import '../models/game_state.dart';
import '../models/player.dart';
import '../models/player_object.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/modify_event_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'target/target.dart';
import 'targeted_effect.dart';

/// Deals damage to a target.
class DamageEffect extends TargetedEffect {
  /// Amount of damage to deal.
  final int damage;
  final int _targetIndex;

  /// [target] is target to request. [targetResult] returns from the request.
  /// [targetIndex] counts through list of targets to apply damage.
  const DamageEffect({
    required Player controller,
    required Target target,
    TargetResult targetResult = const UnfilledTargetRequest(),
    int targetIndex = 0,
    required this.damage,
    bool resolved = false,
  })  : _targetIndex = targetIndex,
        super(
            controller: controller,
            target: target,
            targetResult: targetResult,
            resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    if (targetResult == const UnfilledTargetRequest()) {
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
        if (_targetIndex == targetResult.targets.length - 1) {
          return [
            _generateStateChange(targetResult.targets[_targetIndex]),
            ResolveEventStateChange(event: this),
          ];
        }
        // Otherwise do one target and increment
        else {
          return [
            _generateStateChange(targetResult.targets[_targetIndex]),
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
      targetIndex: _targetIndex + 1,
      damage: damage,
      resolved: resolved);

  @override
  DamageEffect copyWithTarget(TargetResult targetResult) => DamageEffect(
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
