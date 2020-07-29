import 'package:meta/meta.dart';

import '../exceptions/state_change_exception.dart';
import '../game_state/game_state.dart';
import '../objects/card_object.dart';
import 'state_change.dart';
import '../extensions/list_replace.dart';

class ModifyEnteredFieldThisTurnStateChange extends StateChange {
  final CardObject card;
  final bool enteredFieldThisTurn;

  const ModifyEnteredFieldThisTurnStateChange(
      {@required this.card, @required this.enteredFieldThisTurn});

  @override
  GameState apply(GameState state) {
    if (!state.cards.contains(card)) {
      throw const StateChangeException(
          'MoveCardStateChange: Provided card not found exactly once in state');
    } else {
      final newCard = state
          .getCard(card)
          .copyWith({'enteredFieldThisTurn': enteredFieldThisTurn});
      final newCards = state.cards.replaceSingle(card, newCard);

      return state.copyWith(cards: newCards);
    }
  }

  @override
  List<Object> get props => [card, enteredFieldThisTurn];
}
