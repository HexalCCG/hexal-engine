import '../extensions/list_replace.dart';
import '../game_state/game_state.dart';
import '../game_state/location.dart';
import '../objects/card_object.dart';
import 'state_change.dart';

/// StateChange to move a card.
class MoveCardStateChange extends StateChange {
  /// Card to move.
  final CardObject card;

  /// Location to move the card to.
  final Location location;

  /// Move [card] to [location].
  const MoveCardStateChange({required this.card, required this.location});

  @override
  GameState apply(GameState state) {
    assert(state.cards.contains(card));

    final newCard = state.getCard(card).copyWithBase(location: location);
    final newCards = state.cards.replaceSingle(card, newCard);

    return state.copyWith(cards: newCards);
  }

  @override
  List<Object> get props => [card, location];
}
