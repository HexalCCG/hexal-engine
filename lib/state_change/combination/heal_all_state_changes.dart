import '../../game_state/game_state.dart';
import '../heal_card_state_change.dart';
import '../state_change.dart';

class HealAllStateChanges {
  /// Sets the damage of all cards in the state to 0.
  static List<StateChange> generate(GameState state) {
    return state.cards.map((e) => HealCardStateChange(card: e)).toList();
  }
}
