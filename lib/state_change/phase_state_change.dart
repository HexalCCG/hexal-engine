import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../game_state/turn_phase.dart';
import 'state_change.dart';

class PhaseStateChange extends StateChange {
  final TurnPhase phase;
  const PhaseStateChange({@required this.phase});

  @override
  List<Object> get props => [phase];

  @override
  GameState apply(GameState state) {
    return state.copyWith(turnPhase: phase);
  }
}
