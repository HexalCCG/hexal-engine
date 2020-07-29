import 'package:hexal_engine/cards/mi_creature.dart';
import 'package:hexal_engine/effect/target/target.dart';
import 'package:hexal_engine/exceptions/event_exceptipn.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/objects/game_object.dart';

class CreatureTarget extends Target {
  final GameObject target;

  const CreatureTarget({this.target});

  @override
  bool get targetSet => target != null;

  @override
  CreatureTarget setTarget(dynamic target) {
    if (!targetValid(target)) {
      throw EventException('Target set to invalid value');
    }
    return CreatureTarget(target: target);
  }

  @override
  bool targetValid(target) => ((target is CardObject) &&
      (target is ICreature) &&
      (target.location == Location.battlefield));

  @override
  List<Object> get props => [target];
}
