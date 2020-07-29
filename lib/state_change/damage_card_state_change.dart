import 'package:hexal_engine/cards/mi_creature.dart';
import 'package:meta/meta.dart';

import '../exceptions/state_change_exception.dart';
import '../game_state/game_state.dart';
import '../objects/card_object.dart';
import 'state_change.dart';

/// Increases the damage property of the provided card by an amount.
class DamageCardStateChange extends StateChange {
  final CardObject card;
  final int damage;

  const DamageCardStateChange({@required this.card, @required this.damage})
      : assert(card != null),
        assert(card is ICreature),
        assert(damage >= 0);

  @override
  GameState apply(GameState state) {
    final index = state.cards.indexOf(card);
    if (index == -1) {
      throw const StateChangeException(
          'DamageCardStateChange: Provided card not found in state');
    } else {
      final newDamage = (card as ICreature).damage + damage;
      final newCard = card.copyWith({'damage': newDamage});
      final newCards = state.cards.toList()
        ..replaceRange(index, index, newCard);
      return state.copyWith(cards: newCards);
    }
  }

  @override
  List<Object> get props => [card, damage];
}
