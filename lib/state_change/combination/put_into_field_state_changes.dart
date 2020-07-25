import 'package:hexal_engine/event/on_card_enter_field_event.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/state_change/add_stack_event_state_change.dart';
import 'package:hexal_engine/state_change/modify_entered_field_this_turn_state_change.dart';
import 'package:hexal_engine/state_change/move_card_state_change.dart';
import 'package:hexal_engine/state_change/state_change.dart';

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
      AddStackEventStateChange(event: OnCardEnterFieldEvent(card: card)),
    ];
  }
}
