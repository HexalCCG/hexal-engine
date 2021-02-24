import '../card/creature.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// Clears damage from all cards.
class ClearAllDamageStateChange extends StateChange {
  /// Clears damage from all cards.
  const ClearAllDamageStateChange();

  @override
  GameState apply(GameState state) {
    final newCards = state.cards.map((card) {
      if (card is Creature) {
        // Clear damage from creature cards.
        return card.copyWithCreature(damage: 0);
      } else {
        // Do not modify cards that aren't creatures.
        return card;
      }
    }).toList();
    return state.copyWith(cards: newCards);
  }

  @override
  List<Object> get props => [];
}
