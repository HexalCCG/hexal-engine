import 'package:hexal_engine/cards/mi_creature.dart';
import 'package:meta/meta.dart';

import '../exceptions/state_change_exception.dart';
import '../game_state/game_state.dart';
import '../objects/card_object.dart';
import 'state_change.dart';
import '../extensions/list_replace.dart';

/// Sets the damage property of the provided card to 0.
class HealCardStateChange extends StateChange {
  final CardObject card;

  const HealCardStateChange({@required this.card}) : assert(card is ICreature);

  @override
  GameState apply(GameState state) {
    final index = state.cards.indexOf(card);
    if (index == -1) {
      throw const StateChangeException(
          'HealCardStateChange: Provided card not found in state');
    } else {
      final newCard = card.copyWith({'damage': 0});
      // final newCards = state.cards.toList()
      //   ..replaceRange(index, index, [newCard]);
      final newCards = state.cards.toList().replaceSingle(card, newCard);
      print(state.cards);
      print(newCards);
      return state.copyWith(cards: newCards);
    }
  }

  @override
  List<Object> get props => [card];
}
