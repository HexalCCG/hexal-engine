import 'package:hexal_engine/models/game_object.dart';
import 'package:hexal_engine/models/game_object_reference.dart';

import '../cards/creature.dart';
import '../exceptions/state_change_exception.dart';
import '../extensions/list_replace.dart';
import '../models/card_object.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// Increases the damage property of the provided card by an amount.
class DamageCreatureStateChange extends StateChange {
  /// Creature to damage.
  final GameObjectReference creature;

  /// Damage to deal.
  final int damage;

  /// Increases [creature]'s damage property by [damage].
  const DamageCreatureStateChange(
      {required this.creature, required this.damage});

  @override
  GameState apply(GameState state) {
    if (!state.containsCardWithId(creature.id)) {
      throw (StateChangeException('Card with that id not found in state.'));
    }
    final oldCard = state.getCardById(creature.id);
    var newCard = oldCard;
    if (newCard is Creature) {
      newCard = newCard.copyWithCreature(damage: newCard.damage + damage);
    } else {
      throw (StateChangeException(
          'Damage creature must be provided with a creature.'));
    }
    return state.copyWith(cards: state.cards.replaceSingle(oldCard, newCard));
  }

  @override
  List<Object> get props => [creature, damage];
}
