import '../exceptions/state_change_exception.dart';
import '../game_state/game_state.dart';
import '../objects/card_object.dart';
import 'state_change.dart';

/// Sets the damage property of the provided card to 0.
class HealCardStateChange extends StateChange {
  final CardObject card;

  const HealCardStateChange({this.card});

  @override
  GameState apply(GameState state) {
    try {
      final newCard = state.cards
          .singleWhere((element) => element == card)
          .copyWith({'damage': 0});
      final newCards = state.cards.toList()
        ..remove(card)
        ..add(newCard);

      return state.copyWith(cards: newCards);
    } catch (e) {
      if (e is StateError) {
        throw const StateChangeException(
            'HealCardStateChange: Provided card not found exactly once in state');
      } else {
        rethrow;
      }
    }
  }

  @override
  List<Object> get props => [card];
}
