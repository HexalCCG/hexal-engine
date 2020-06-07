import 'package:hexal_engine/engine/engine_state_change.dart';
import 'package:hexal_engine/model/actions/action.dart';
import 'package:hexal_engine/model/game_state.dart';
import 'package:hexal_engine/model/state_change/state_change.dart';

import 'engine_process.dart';

class Engine {
  /// Generates a list of changes following the provided action.
  static List<StateChange> processAction(GameState state, Action action) =>
      engineProcess(state, action);

  static GameState processStateChange(
          GameState state, List<StateChange> changes) =>
      engineStateChange(state, changes);
}
