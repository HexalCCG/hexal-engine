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

    final newCard =
        (state.getCard(creature) as Creature).copyWithCreature(exhausted: true);
    final newCards = state.cards.replaceSingle(creature, newCard);
    return state.copyWith(cards: newCards);
  }

  @override
  List<Object> get props => [creature];
}
