import '../card/creature.dart';
import '../exceptions/state_change_exception.dart';
import '../extensions/replace_single.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// Increases the damage property of the provided card by an amount.
class DamageCreatureStateChange extends StateChange {
  /// Creature to damage.
  final int creature;

  /// Damage to deal.
  final int damage;

  /// Increases [creature]'s damage property by [damage].
  const DamageCreatureStateChange(
      {required this.creature, required this.damage});

  @override
  GameState apply(GameState state) {
    if (!state.containsCardWithId(creature)) {
      throw (const StateChangeException(
          'Card with that id not found in state.'));
    }
    final oldCard = state.getCardById(creature);
    var newCard = oldCard;
    if (newCard is Creature) {
      newCard = newCard.copyWithCreature(damage: newCard.damage + damage);
    } else {
      throw (const StateChangeException(
          'Damage creature must be provided with a creature.'));
    }
    return state.copyWith(
        cards: state.cards.replaceSingle(oldCard, newCard).toList());
  }

  @override
  List<Object> get props => [creature, damage];
}
