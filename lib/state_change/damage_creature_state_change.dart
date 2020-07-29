import 'package:hexal_engine/cards/mi_creature.dart';
import 'package:meta/meta.dart';

import '../exceptions/state_change_exception.dart';
import '../game_state/game_state.dart';
import '../objects/card_object.dart';
import 'state_change.dart';
import '../extensions/list_replace.dart';

/// Increases the damage property of the provided card by an amount.
class DamageCreatureStateChange extends StateChange {
  final CardObject card;
  final int damage;

  const DamageCreatureStateChange({@required this.card, @required this.damage})
      : assert(card != null),
        assert(card is ICreature),
        assert(damage >= 0);

  @override
  GameState apply(GameState state) {
    if (!state.cards.contains(card)) {
      throw const StateChangeException(
          'DamageCreatureStateChange: Provided card not found in state');
    } else {
      final newCard = state
          .getCard(card)
          .copyWith({'damage': (card as ICreature).damage + damage});
      final newCards = state.cards.replaceSingle(card, newCard);
      return state.copyWith(cards: newCards);
    }
  }

  @override
  List<Object> get props => [card, damage];
}
