import '../cards/creature.dart';
import '../extensions/list_replace.dart';
import '../models/card_object.dart';
import '../models/game_state.dart';
import '../models/location.dart';
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

    var newCard = state.getCard(card);
    newCard = newCard.copyWith(location: Location.field);

    if (newCard is Creature) {
      newCard = newCard.copyWithCreature(
          enteredFieldThisTurn: true, exhausted: false, damage: 0);
    }

    return state.copyWith(cards: state.cards.replaceSingle(card, newCard));
  }

  @override
  List<Object> get props => [card];
}
