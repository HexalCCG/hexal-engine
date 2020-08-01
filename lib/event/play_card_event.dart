import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../game_state/location.dart';
import '../objects/card_object.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/modify_entered_field_this_turn_state_change.dart';
import '../state_change/move_card_state_change.dart';
import '../state_change/resolve_event_state_change.dart';
import '../state_change/state_change.dart';
import 'event.dart';
import 'on_card_enter_field_event.dart';

class PlayCardEvent extends Event {
  final CardObject card;

  const PlayCardEvent({@required this.card, bool resolved = false})
      : super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    return [
      MoveCardStateChange(
        card: card,
        location: Location.battlefield,
      ),
      ModifyEnteredFieldThisTurnStateChange(
        card: card,
        enteredFieldThisTurn: true,
      ),
      AddEventStateChange(event: OnCardEnterFieldEvent(card: card)),
      ResolveEventStateChange(event: this)
    ];
  }

  @override
  PlayCardEvent get copyResolved => PlayCardEvent(card: card, resolved: true);

  @override
  List<Object> get props => [card, resolved];
}
