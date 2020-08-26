import 'package:hexal_engine/models/game_object_reference.dart';

import '../cards/creature.dart';
import '../exceptions/state_change_exception.dart';
import '../extensions/list_replace.dart';
import '../models/card_object.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// StateChange to exhaust a creature.
class ExhaustCreatureStateChange extends StateChange {
  /// Creature to exhaust.
  final GameObjectReference creature;

  /// Exhausts [creature].
  const ExhaustCreatureStateChange({required this.creature});

  @override
  GameState apply(GameState state) {
    if (!state.containsCardWithId(creature.id)) {
      throw (StateChangeException('Card with that id not found in state.'));
    }
    final oldCard = state.getCardById(creature.id);
    var newCard = oldCard;
    if (newCard is Creature) {
      newCard = newCard.copyWithCreature(exhausted: true);
    } else {
      throw (StateChangeException(
          'Exhaust creature provided with non-creature.'));
    }

    return state.copyWith(cards: state.cards.replaceSingle(oldCard, newCard));
  }

  @override
  List<Object> get props => [creature];
}
