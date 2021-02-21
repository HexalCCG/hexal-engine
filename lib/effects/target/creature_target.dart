import '../../card/creature.dart';
import '../../models/enums/location.dart';
import '../../models/enums/player.dart';
import '../../models/game_state.dart';
import 'target.dart';

/// Target a creature on either side of the field.
class CreatureTarget extends Target {
  @override
  final Player controller;
  @override
  final bool optional;

  /// [optional] is whether this effect can be passed if a valid target exists.
  const CreatureTarget({
    required this.controller,
    this.optional = false,
  });

  @override
  bool targetValid(GameState state, List<int> targets) {
    if (targets.length != 1) {
      return false;
    }
    final _target = state.getCardById(targets.first);
    return (_target is Creature) && (_target.location == Location.field);
  }

  @override
  bool anyValid(GameState state) {
    return state.cards.any((card) => targetValid(state, [card.id]));
  }

  @override
  List<Object> get props => [controller, optional];

  /// Create this target from json.
  static CreatureTarget fromJson(List<dynamic> json) => CreatureTarget(
        controller: Player.fromIndex(json[0] as int),
        optional: json[1] as bool,
      );
}
