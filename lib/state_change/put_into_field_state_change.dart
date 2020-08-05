import 'package:meta/meta.dart';

import '../extensions/list_replace.dart';
import '../game_state/game_state.dart';
import '../game_state/location.dart';
import '../objects/card_object.dart';
import 'move_card_state_change.dart';

class PutIntoFieldStateChange extends MoveCardStateChange {
  const PutIntoFieldStateChange({@required CardObject card})
      : super(card: card, location: Location.field);
  @override
  GameState apply(GameState state) {
    state = super.apply(state);

    final newCard = state.getCard(card).copyWith(
        {'enteredFieldThisTurn': true, 'attackedThisTurn': false, 'damage': 0});

    return state.copyWith(cards: state.cards.replaceSingle(card, newCard));
  }

  @override
  List<Object> get props => [card];
}
