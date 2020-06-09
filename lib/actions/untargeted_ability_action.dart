import 'package:hexal_engine/state_change/state_change.dart';
import 'package:hexal_engine/game_state.dart';
import 'package:meta/meta.dart';

import '../objects/i_targetable.dart';
import 'action.dart';

class UntargetedAbilityAction extends Action {
  final ITargetable object;
  final int ability;
  final ITargetable subject;

  const UntargetedAbilityAction({
    @required this.object,
    @required this.ability,
    @required this.subject,
  });

  @override
  List<Object> get props => [object, ability, subject];

  @override
  List<StateChange> apply(GameState state) {
    // TODO: implement apply
    throw UnimplementedError();
  }
}
