import '../cards/creature.dart';
import '../extensions/list_replace.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// StateChange to exhaust a creature.
class ExhaustCreatureStateChange extends StateChange {
  /// Creature to exhaust.
  final Creature creature;

  /// Exhausts [creature].
  const ExhaustCreatureStateChange({required this.creature});

  @override
  GameState apply(GameState state) {
    assert(state.cards.contains(creature));

    var newCard = state.getCard(creature);

    if (newCard is Creature) {
      newCard = newCard.copyWithCreature(exhausted: true);
    }

    return state.copyWith(cards: state.cards.replaceSingle(creature, newCard));
  }

  @override
  List<Object> get props => [creature];
}
