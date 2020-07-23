import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/state_change/modify_entered_field_this_turn_state_change.dart';
import 'package:hexal_engine/state_change/move_card_state_change.dart';
import 'package:hexal_engine/state_change/state_change.dart';

class PutIntoFieldStateChanges {
  static List<StateChange> generate(CardObject card) {
    return [
      MoveCardStateChange(
        card: card,
        location: Location.battlefield,
      ),
      ModifyEnteredFieldThisTurnStateChange(
        card: card.copyWith({'location': Location.battlefield}),
        enteredFieldThisTurn: true,
      ),
    ];
  }
}
