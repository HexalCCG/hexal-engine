import '../exceptions/state_change_exception.dart';
import '../extensions/list_replace.dart';
import '../models/enums/location.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// StateChange to move a card.
class MoveCardStateChange extends StateChange {
  /// Card to move.
  final int card;

  /// Location to move the card to.
  final Location location;

  /// Move [card] to [location].
  const MoveCardStateChange({required this.card, required this.location});

  @override
  GameState apply(GameState state) {
    if (!state.containsCardWithId(card)) {
      throw (StateChangeException('Card with that id not found in state.'));
    }
    final oldCard = state.getCardById(card);
    final newCard = oldCard.copyWith(location: location);

    return state.copyWith(cards: state.cards.replaceSingle(oldCard, newCard));
  }

  @override
  List<Object> get props => [card, location];
}
