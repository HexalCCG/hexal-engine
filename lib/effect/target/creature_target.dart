import 'package:hexal_engine/game_state/player.dart';

import '../../cards/mi_creature.dart';
import 'target.dart';
import '../../exceptions/event_exceptipn.dart';
import '../../game_state/location.dart';
import '../../objects/card_object.dart';
import '../../objects/game_object.dart';
import 'package:meta/meta.dart';

class CreatureTarget extends Target {
  final bool optional;

  const CreatureTarget({this.optional = false, @required Player controller})
      : super(controller: controller);

  @override
  bool targetValid(target) {
    //TODO: should be able to pass if no valid targets exist
    if (optional && target == null) {
      return true;
    }
    return ((target is CardObject) &&
        (target is ICreature) &&
        (target.location == Location.battlefield));
  }

  @override
  TargetResult createResult(dynamic target) {
    if (!targetValid(target)) {
      throw EventException('Create target result failed: invalid target');
    }
    if (target == null) {
      return EmptyTargetResult();
    }
    return CreatureTargetResult(target: target);
  }

  @override
  List<Object> get props => [controller];
}

class CreatureTargetResult extends TargetResult {
  final GameObject target;

  const CreatureTargetResult({@required this.target});

  @override
  List<GameObject> get targets => [target];

  @override
  List<Object> get props => [target];
}
