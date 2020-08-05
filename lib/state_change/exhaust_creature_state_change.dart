import 'package:hexal_engine/exceptions/state_change_exception.dart';
import 'package:meta/meta.dart';
import '../extensions/list_replace.dart';

import '../cards/creature.dart';
import '../game_state/game_state.dart';
import 'state_change.dart';

class ExhaustCreatureStateChange extends StateChange {
  final Creature creature;

  const ExhaustCreatureStateChange({@required this.creature});

  @override
  GameState apply(GameState state) {
    if (!state.cards.contains(creature)) {
      throw const StateChangeException(
          'ExhaustCreatureStateChange: Provided card not found in state');
    } else {
      final newCard = state.getCard(creature).copyWith({'exhausted': true});
      final newCards = state.cards.replaceSingle(creature, newCard);
      return state.copyWith(cards: newCards);
    }
  }

  @override
  List<Object> get props => [creature];
}
