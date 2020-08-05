import 'package:meta/meta.dart';

import '../cards/creature.dart';
import '../exceptions/state_change_exception.dart';
import '../extensions/list_replace.dart';
import '../game_state/game_state.dart';
import 'state_change.dart';

/// Increases the damage property of the provided card by an amount.
class DamageCreatureStateChange extends StateChange {
  final Creature creature;
  final int damage;

  const DamageCreatureStateChange(
      {@required this.creature, @required this.damage});

  @override
  GameState apply(GameState state) {
    if (!state.cards.contains(creature)) {
      throw const StateChangeException(
          'DamageCreatureStateChange: Provided card not found in state');
    } else {
      final newCard = state
          .getCard(creature)
          .copyWith({'damage': creature.damage + damage});
      final newCards = state.cards.replaceSingle(creature, newCard);
      return state.copyWith(cards: newCards);
    }
  }

  @override
  List<Object> get props => [creature, damage];
}
