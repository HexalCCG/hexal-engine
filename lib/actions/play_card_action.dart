import 'package:hexal_engine/state_change/state_change.dart';
import 'package:hexal_engine/game_state.dart';
import 'package:meta/meta.dart';

import '../objects/i_targetable.dart';
import 'action.dart';

class PlayCardAction extends Action {
  final ITargetable object;

  const PlayCardAction({@required this.object});

  @override
  List<Object> get props => [object];

  @override
  List<StateChange> apply(GameState state) {
    // TODO: implement apply
    throw UnimplementedError();
  }
}
