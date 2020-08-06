import '../cards/creature.dart';
import '../extensions/list_replace.dart';
import '../game_state/game_state.dart';
import '../game_state/location.dart';
import '../objects/card_object.dart';
import 'state_change.dart';

/// StateChange to put a card into the field.
class PutIntoFieldStateChange extends StateChange {
  /// Card to put into field.
  final CardObject card;

  /// Puts [card] into the field.
  const PutIntoFieldStateChange({required this.card});

  @override
  GameState apply(GameState state) {
    assert(state.cards.contains(card));

    var newCard = state.getCard(card).copyWithBase(location: Location.field);
    if (newCard is Creature) {
      newCard = newCard.copyWithCreature(
          enteredFieldThisTurn: true, exhausted: false, damage: 0);
    }

    final newCards = state.cards.replaceSingle(card, newCard);
    return state.copyWith(cards: newCards);
  }

  @override
  List<Object> get props => [card];
}
