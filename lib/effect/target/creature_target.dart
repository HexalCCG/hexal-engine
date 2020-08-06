import '../../cards/creature.dart';
import '../../game_state/game_state.dart';
import '../../game_state/location.dart';
import '../../game_state/player.dart';
import '../../objects/game_object.dart';
import 'target.dart';

/// Target a creature on either side of the field.
class CreatureTarget extends Target {
  /// [optional] is whether this effect can be passed if a valid target exists.
  const CreatureTarget({bool optional = false, required Player controller})
      : super(controller: controller, optional: optional);

  @override
  bool targetValid(List<GameObject> targets) {
    return ((targets.length == 1) &&
        (targets.first is Creature) &&
        ((targets.first as Creature).location == Location.field));
  }

  @override
  bool anyValid(GameState state) {
    return state.cards.any((card) => targetValid([card]));
  }

  @override
  TargetResult createResult(List<GameObject> targets) {
    assert(targetValid(targets));
    return CreatureTargetResult(target: targets.first as Creature);
  }

  @override
  List<Object> get props => [controller, optional];
}

/// Result from a CreatureTarget
class CreatureTargetResult extends TargetResult {
  final Creature _target;

  /// [target] is a single targeted Creature.
  const CreatureTargetResult({required Creature target}) : _target = target;

  @override
  List<GameObject> get targets => [_target];

  @override
  List<Object> get props => [targets];
}
