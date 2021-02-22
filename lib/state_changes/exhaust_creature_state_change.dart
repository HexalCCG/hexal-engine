import '../card/creature.dart';
import '../exceptions/state_change_exception.dart';
import '../extensions/list_replace.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// StateChange to exhaust a creature.
class ExhaustCreatureStateChange extends StateChange {
  /// Creature to exhaust.
  final int creature;

  /// Exhausts [creature].
  const ExhaustCreatureStateChange({required this.creature});

  @override
  GameState apply(GameState state) {
    if (!state.containsCardWithId(creature)) {
      throw (const StateChangeException(
          'Card with that id not found in state.'));
    }
    final oldCard = state.getCardById(creature);
    var newCard = oldCard;
    if (newCard is Creature) {
      newCard = newCard.copyWithCreature(exhausted: true);
    } else {
      throw (const StateChangeException(
          'Exhaust creature provided with non-creature.'));
    }

    return state.copyWith(cards: state.cards.replaceSingle(oldCard, newCard));
  }

  @override
  List<Object> get props => [creature];
}
