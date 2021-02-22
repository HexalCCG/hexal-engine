import '../card/creature.dart';
import '../exceptions/state_change_exception.dart';
import '../extensions/replace_single.dart';
import '../models/enums/location.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// StateChange to put a card into the field.
class PutIntoFieldStateChange extends StateChange {
  /// Card to put into field.
  final int card;

  /// Puts [card] into the field.
  const PutIntoFieldStateChange({required this.card});

  @override
  GameState apply(GameState state) {
    if (!state.containsCardWithId(card)) {
      throw (const StateChangeException(
          'Card with that id not found in state.'));
    }
    final oldCard = state.getCardById(card);
    var newCard = oldCard.copyWith(location: Location.field);

    if (newCard is Creature) {
      newCard = newCard.copyWithCreature(
          enteredFieldThisTurn: true, exhausted: false, damage: 0);
    }

    return state.copyWith(
        cards: state.cards.replaceSingle(oldCard, newCard).toList());
  }

  @override
  List<Object> get props => [card];
}
