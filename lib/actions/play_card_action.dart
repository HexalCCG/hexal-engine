import '../events/play_card_event.dart';
import '../exceptions/action_exception.dart';
import '../models/enums/location.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/move_card_state_change.dart';
import '../state_changes/priority_state_change.dart';
import '../state_changes/state_change.dart';
import 'action.dart';

/// Plays the card from your hand.
class PlayCardAction extends Action {
  /// Card to play.
  final int card;

  /// Plays [card] from priority player's hand.
  const PlayCardAction({required this.card});

  @override
  bool valid(GameState state) {
    final _card = state.getCardById(card);

    if (state.stack.isNotEmpty) {
      // Cannot play cards if stack is not empty.
      return false;
    }
    if (!state
        .getCardsByLocation(state.priorityPlayer, Location.hand)
        .contains(_card)) {
      // Card not found in hand.
      return false;
    }
    if (state.activePlayer != state.priorityPlayer) {
      // Cannot play card on opponent's turn.
      return false;
    }
    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      throw const ActionException('PlayCardAction Exception: invalid argument');
    }

    return [
      MoveCardStateChange(card: card, location: Location.limbo),
      AddEventStateChange(event: PlayCardEvent(card: card)),
      PriorityStateChange(player: state.activePlayer),
    ];
  }

  @override
  List<Object> get props => [card];

  /// Create from json.
  static PlayCardAction fromJson(List<dynamic> json) => PlayCardAction(
        card: json[0] as int,
      );
}
