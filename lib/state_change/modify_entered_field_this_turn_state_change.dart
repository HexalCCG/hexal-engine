import 'package:meta/meta.dart';

import '../exceptions/state_change_exception.dart';
import '../game_state/game_state.dart';
import '../objects/card_object.dart';
import 'state_change.dart';

class ModifyEnteredFieldThisTurnStateChange extends StateChange {
  final CardObject card;
  final bool enteredFieldThisTurn;

  const ModifyEnteredFieldThisTurnStateChange(
      {@required this.card, @required this.enteredFieldThisTurn});

  @override
  GameState apply(GameState state) {
    try {
      final newCard = state.cards
          .singleWhere((element) => element == card)
          .copyWith({'enteredFieldThisTurn': enteredFieldThisTurn});
      final newCards = state.cards.toList()
        ..remove(card)
        ..add(newCard);

      return state.copyWith(cards: newCards);
    } catch (e) {
      if (e is StateError) {
        throw const StateChangeException(
            'MoveCardStateChange: Provided card not found exactly once in state');
      } else {
        rethrow;
      }
    }
  }

  @override
  List<Object> get props => [card, enteredFieldThisTurn];
}
