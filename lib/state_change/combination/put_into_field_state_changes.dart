import '../../event/on_card_enter_field_event.dart';
import '../../game_state/location.dart';
import '../../objects/card_object.dart';
import '../add_event_state_change.dart';
import '../modify_entered_field_this_turn_state_change.dart';
import '../move_card_state_change.dart';
import '../state_change.dart';

/// Puts a card into the battlefield.
class PutIntoFieldStateChanges {
  static List<StateChange> generate(CardObject card) {
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
    ];
  }
}
