import '../card/creature.dart';
import '../extensions/replace_single.dart';
import '../models/card.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// Clears single-turn flags from a card.
class EndTurnClearStateChange extends StateChange {
  /// Card to clear flags from.
  final Card card;

  /// Clear single-turn flags from [card].
  const EndTurnClearStateChange({required this.card});

  @override
  GameState apply(GameState state) {
    final oldCard = state.getCardById(card.id);
    var newCard = oldCard;

    if (newCard is Creature) {
      /// Clear creature flags.
      newCard = newCard.copyWithCreature(
        exhausted: false,
        enteredFieldThisTurn: false,
        damage: 0,
      );
    }
    return state.copyWith(
        cards: state.cards.replaceSingle(oldCard, newCard).toList());
  }

  @override
  List<Object> get props => [card];
}
