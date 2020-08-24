import '../cards/creature.dart';
import '../exceptions/state_change_exception.dart';
import '../extensions/list_replace.dart';
import '../models/card_object.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// Increases the damage property of the provided card by an amount.
class DamageCreatureStateChange extends StateChange {
  /// Creature to damage.
  final CardObject creature;

  /// Damage to deal.
  final int damage;

  /// Increases [creature]'s damage property by [damage].
  const DamageCreatureStateChange(
      {required this.creature, required this.damage});

  @override
  GameState apply(GameState state) {
    var newCard = state.getCardById(creature.id);
    if (newCard is Creature) {
      newCard = newCard.copyWithCreature(damage: newCard.damage + damage);
    } else {
      throw (StateChangeException(
          'Damage creature must be provided with a creature.'));
    }
    final newCards = state.cards.replaceSingle(creature, newCard);
    return state.copyWith(cards: newCards);
  }

  @override
  List<Object> get props => [creature, damage];
}
