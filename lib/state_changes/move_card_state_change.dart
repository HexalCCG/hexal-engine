import '../extensions/list_replace.dart';
import '../models/card_object.dart';
import '../models/game_state.dart';
import '../models/location.dart';
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

    final newCard = state.getCard(card).copyWith(location: location);
    final newCards = state.cards.replaceSingle(card, newCard);

    return state.copyWith(cards: newCards);
  }

  @override
  List<Object> get props => [card, location];
}
