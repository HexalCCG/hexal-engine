import '../exceptions/state_change_exception.dart';
import '../model/game_state.dart';
import 'state_change.dart';

/// Add a card entering the field to the history.
class HistoryEnteredFieldStateChange extends StateChange {
  /// Card that entered the field.
  final int card;

  /// Add a card entering the field to the history.
  const HistoryEnteredFieldStateChange({required this.card});

  @override
  GameState apply(GameState state) {
    if (!state.containsCardWithId(card)) {
      throw (const StateChangeException(
          'Card with that id not found in state.'));
    }

    return state.copyWith(history: state.history.addEnteredFieldThisTurn(card));
  }

  @override
  List<Object> get props => [card];
}
