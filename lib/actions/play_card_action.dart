import 'package:meta/meta.dart';

import '../exceptions/action_exception.dart';
import '../game_state/game_state.dart';
import '../game_state/location.dart';
import '../objects/card_object.dart';
import '../state_change/combination/play_card_state_changes.dart';
import '../state_change/priority_state_change.dart';
import '../state_change/state_change.dart';
import 'action.dart';

class PlayCardAction extends Action {
  final CardObject card;

  const PlayCardAction({@required this.card});

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
      ...PlayCardStateChanges.generate(card),
      PriorityStateChange(player: state.notPriorityPlayer),
    ];
  }

  @override
  List<Object> get props => [card];
}
