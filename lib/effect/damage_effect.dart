import 'package:hexal_engine/effect/target/target.dart';
import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/state_change.dart';
import 'effect.dart';
import 'i_targetted.dart';

class DamageEffect extends Effect implements ITargetted {
  final Target target;
  final int damage;

  const DamageEffect({@required this.target, @required this.damage});

  @override
  bool targetValid(target) => target.targetValid(target);

  @override
  bool get targetSet => target.targetSet;

  @override
  DamageEffect copyWithTarget(target) {
    // TODO: implement copyWithTarget
    throw UnimplementedError();
  }

  @override
  List<StateChange> apply(GameState state) {
    return [
      AddEventStateChange(event: DamageEffect(target: target, damage: damage))
    ];
  }

  @override
  List<Object> get props => [target, damage];
}
