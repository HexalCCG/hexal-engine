import '../../event/play_card_event.dart';
import '../../game_state/location.dart';
import '../../objects/card_object.dart';
import '../add_event_state_change.dart';
import '../move_card_state_change.dart';
import '../state_change.dart';

class PlayCardStateChanges {
  static List<StateChange> generate(CardObject card) {
    return [
      MoveCardStateChange(card: card, location: Location.limbo),
      AddEventStateChange(
          event:
              PlayCardEvent(card: card.copyWith({'location': Location.limbo}))),
    ];
  }
}
