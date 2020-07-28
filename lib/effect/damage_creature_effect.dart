import 'package:meta/meta.dart';

import '../cards/mi_creature.dart';
import '../game_state/game_state.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/state_change.dart';
import 'effect.dart';
import 'i_input_required.dart';

class DamageCreatureEffect extends Effect implements IInputRequired {
  final ICreature target;
  final int damage;

  const DamageCreatureEffect({@required this.target, @required this.damage});

  @override
  // TODO: implement needsInput
  bool get needsInput => throw UnimplementedError();

  @override
  bool targetValid(target) {
    // TODO: implement targetValid
    throw UnimplementedError();
  }

  @override
  copyWithTarget(target) {
    // TODO: implement copyWithTarget
    throw UnimplementedError();
  }

  @override
  List<StateChange> apply(GameState state) {
    return [
      AddEventStateChange(
          event: DamageCreatureEffect(target: target, damage: damage))
    ];
  }

  @override
  List<Object> get props => [target, damage];
}
