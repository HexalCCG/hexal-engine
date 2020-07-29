import 'package:meta/meta.dart';

import '../exceptions/state_change_exception.dart';
import '../game_state/game_state.dart';
import '../game_state/location.dart';
import '../objects/card_object.dart';
import 'state_change.dart';
import '../extensions/list_replace.dart';

class MoveCardStateChange extends StateChange {
  final CardObject card;
  final Location location;

  const MoveCardStateChange({@required this.card, @required this.location});

  @override
  GameState apply(GameState state) {
    if (!state.cards.contains(card)) {
      throw const StateChangeException(
          'MoveCardStateChange: Provided card not found exactly once in state');
    } else {
      final newCard = state.getCard(card).copyWith({'location': location});
      final newCards = state.cards.replaceSingle(card, newCard);

      return state.copyWith(cards: newCards);
    }
  }

  @override
  List<Object> get props => [card, location];
}
