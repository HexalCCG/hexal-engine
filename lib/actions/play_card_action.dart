import 'package:hexal_engine/state_change/priority_state_change.dart';
import 'package:meta/meta.dart';

import '../event/play_card_event.dart';
import '../exceptions/action_exception.dart';
import '../game_state/game_state.dart';
import '../game_state/location.dart';
import '../objects/card_object.dart';
import '../state_change/add_stack_event_state_change.dart';
import '../state_change/move_card_state_change.dart';
import '../state_change/state_change.dart';
import 'action.dart';

class PlayCardAction extends Action {
  final CardObject card;

  const PlayCardAction({@required this.card});

  @override
  List<Object> get props => [card];

  @override
  List<StateChange> apply(GameState state) {
    if (!state
        .getCardsByLocation(state.priorityPlayer, Location.hand)
        .contains(card)) {
      throw ActionException('Card not found in hand');
    }
    if (state.activePlayer != state.priorityPlayer) {
      throw ActionException("Cannot play card on opponent's turn");
    }
    return [
      MoveCardStateChange(card: card, location: Location.limbo),
      AddStackEventStateChange(
          event:
              PlayCardEvent(card: card.copyWith({'location': Location.limbo}))),
      PriorityStateChange(player: state.notPriorityPlayer),
    ];
  }
}
