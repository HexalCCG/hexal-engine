import '../cards/creature.dart';
import '../extensions/list_replace.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// Increases the damage property of the provided card by an amount.
class DamageCreatureStateChange extends StateChange {
  /// Creature to damage.
  final Creature creature;

  /// Damage to deal.
  final int damage;

  /// Increases [creature]'s damage property by [damage].
  const DamageCreatureStateChange(
      {required this.creature, required this.damage});

  @override
  GameState apply(GameState state) {
    assert(state.cards.contains(creature));

    final newCard = (state.getCard(creature) as Creature)
        .copyWithCreature(damage: creature.damage + damage);
    final newCards = state.cards.replaceSingle(creature, newCard);
    return state.copyWith(cards: newCards);
  }

  @override
  List<Object> get props => [creature, damage];
}
