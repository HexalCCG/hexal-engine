import '../cards/creature.dart';
import '../extensions/list_replace.dart';
import '../models/card_object.dart';
import '../models/game_state.dart';
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

    var newCard = state.getCard(card);

    if (newCard is Creature) {
      /// Clear creature flags.
      newCard = newCard.copyWithCreature(
        exhausted: false,
        enteredFieldThisTurn: false,
        damage: 0,
      );
    }
    return state.copyWith(cards: state.cards.replaceSingle(card, newCard));
  }

  @override
  List<Object> get props => [card];
}
