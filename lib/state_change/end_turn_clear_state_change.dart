import 'package:hexal_engine/exceptions/state_change_exception.dart';
import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../objects/card_object.dart';
import 'state_change.dart';
import '../extensions/list_replace.dart';

class EndTurnClearStateChange extends StateChange {
  final CardObject card;

  const EndTurnClearStateChange({@required this.card});

  @override
  GameState apply(GameState state) {
    if (!state.cards.contains(card)) {
      throw const StateChangeException(
          'EndTurnClearStateChange: Provided card not found exactly once in state');
    } else {
      final newCard = state.getCard(card).copyWith({
        'enteredFieldThisTurn': false,
        'attackedThisTurn': false,
        'damage': 0,
      });

      return state.copyWith(cards: state.cards.replaceSingle(card, newCard));
    }
  }

  @override
  List<Object> get props => [card];
}
