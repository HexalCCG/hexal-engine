import '../cards/creature.dart';
import '../exceptions/state_change_exception.dart';
import '../extensions/list_replace.dart';
import '../game_state/game_state.dart';
import '../objects/card_object.dart';
import 'state_change.dart';

/// Clears single-turn flags from a card.
class EndTurnClearStateChange extends StateChange {
  /// Card to clear flags from.
  final CardObject card;

  /// Clear single-turn flags from [card].
  const EndTurnClearStateChange({required this.card});

  @override
  GameState apply(GameState state) {
    assert(state.cards.contains(card));

    if (card is Creature) {
      /// Clear creature flags.
      final newCard = (state.getCard(card) as Creature).copyWithCreature(
        exhausted: false,
        enteredFieldThisTurn: false,
        damage: 0,
      );
      return state.copyWith(cards: state.cards.replaceSingle(card, newCard));
    } else {
      // No non-creature flags so do nothing.
      return state;
    }
  }

  @override
  List<Object> get props => [card];
}
