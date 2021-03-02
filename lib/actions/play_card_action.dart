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
  void validate(GameState state) {
    final _card = state.getCardById(card);

    if (_card.location != Location.hand) {
      // Card not found in hand.
      throw const ActionException('PlayCardAction: Card not in hand.');
    }

    if (!_card.canPlay(state)) {
      throw const ActionException(
          'PlayCardAction: Cannot play that card at this time.');
    }
  }

  @override
  List<StateChange> apply(GameState state) {
    validate(state);

    return [
      MoveCardStateChange(card: card, location: Location.limbo),
      AddEventStateChange(event: PlayCardEvent(card: card)),
      PriorityStateChange(player: state.activePlayer),
    ];
  }

  /// Whether this action can be auto passed.
  static bool canAutoPass(GameState state) {
    return state.cards.every((card) {
      try {
        PlayCardAction(card: card.id).validate(state);
        return false;
      } on ActionException {
        return true;
      }
    });
  }

  @override
  List<Object> get props => [card];

  /// Create from json.
  static PlayCardAction fromJson(List<dynamic> json) => PlayCardAction(
        card: json[0] as int,
      );
}
