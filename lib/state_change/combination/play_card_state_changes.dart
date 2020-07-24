import 'package:hexal_engine/event/play_card_event.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/state_change/add_stack_event_state_change.dart';
import 'package:hexal_engine/state_change/move_card_state_change.dart';
import 'package:hexal_engine/state_change/state_change.dart';

class PlayCardStateChanges {
  static List<StateChange> generate(CardObject card) {
    return [
      MoveCardStateChange(card: card, location: Location.limbo),
      AddStackEventStateChange(
          event:
              PlayCardEvent(card: card.copyWith({'location': Location.limbo}))),
    ];
  }
}
