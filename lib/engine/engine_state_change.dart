import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/state_change/state_change.dart';

GameState engineStateChange(GameState state, List<StateChange> changes) {
  changes.forEach((change) => state = processStateChange(state, change));
  return state;
}

GameState processStateChange(GameState state, StateChange change) =>
    change.apply(state);
