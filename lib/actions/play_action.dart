import 'package:hexal_engine/exceptions/action_exception.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/state_change/add_stack_event_state_change.dart';
import 'package:hexal_engine/state_change/move_card_state_change.dart';
import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../game_state/turn_phase.dart';
import '../objects/card_object.dart';
import '../state_change/active_player_state_change.dart';
import '../state_change/phase_state_change.dart';
import '../state_change/priority_state_change.dart';
import '../state_change/state_change.dart';
import 'action.dart';

class PlayAction extends Action {
  final CardObject cardObject;

  const PlayAction({@required this.cardObject});

  @override
  List<Object> get props => [cardObject];

  @override
  List<StateChange> apply(GameState state) {
    if (!state
        .getCardsByLocation(state.priorityPlayer, Location.hand)
        .contains(cardObject)) {
      throw ActionException('Card not found in hand');
    }
    if (state.activePlayer != state.priorityPlayer) {
      throw ActionException("Cannot play card on opponent's turn");
    }
    return [
      MoveCardStateChange(card: cardObject, location: Location.limbo),
      AddStackEventStateChange(event: PlayCardEvent(cardObject: cardObject)),
    ];
  }
}
