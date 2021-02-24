import '../exceptions/state_change_exception.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// Add a creature to the attacked set of the history.
class HistoryAttackedStateChange extends StateChange {
  /// Creature to exhaust.
  final int creature;

  /// Add a creature to the attacked set of the history.
  const HistoryAttackedStateChange({required this.creature});

  @override
  GameState apply(GameState state) {
    if (!state.containsCardWithId(creature)) {
      throw (const StateChangeException(
          'Card with that id not found in state.'));
    }

    return state.copyWith(history: state.history.addAttackedThisTurn(creature));
  }

  @override
  List<Object> get props => [creature];
}
