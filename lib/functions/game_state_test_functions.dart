import '../actions/pass_action.dart';
import '../models/game_state.dart';

/// Functions for use in testing game state.
class GameStateTestFunctions {
  /// Sumbits pass actions until the stack is empty. Infinite loops are an error but are not checked for here.
  static GameState passUntilEmpty(GameState state) {
    while (state.stack.isNotEmpty) {
      state = state.applyAction(const PassAction());
    }
    return state;
  }
}
