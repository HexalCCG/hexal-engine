import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/state_change/phase_state_change.dart';
import 'package:hexal_engine/model/state_change/priority_state_change.dart';
import 'package:hexal_engine/model/state_change/state_change.dart';

GameState engineStateChange(GameState state, List<StateChange> changes) {
  changes.forEach((change) => state = processStateChange(state, change));
  return state;
}

GameState processStateChange(GameState state, StateChange change) {
  if (change is PhaseStateChange) {
    return state.copyWith(turnPhase: change.phase);
  }
  if (change is PriorityStateChange) {
    return state.copyWith(priorityPlayer: change.player);
  }
  // Unhandled state changes error
  throw UnimplementedError();
}
