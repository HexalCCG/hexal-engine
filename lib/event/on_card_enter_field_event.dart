import 'package:hexal_engine/cards/i_on_enter_field.dart';
import 'package:hexal_engine/event/event.dart';
import 'package:hexal_engine/event/i_incrementing.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/state_change/add_stack_event_state_change.dart';
import 'package:hexal_engine/state_change/increment_stack_event_state_change.dart';
import 'package:hexal_engine/state_change/remove_stack_event_state_change.dart';
import 'package:hexal_engine/state_change/state_change.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:meta/meta.dart';

/// Effect caused by a card entering the battlefield.
class OnCardEnterFieldEvent extends Event implements IIncrementing {
  final CardObject card;
  @override
  final int counter;

  const OnCardEnterFieldEvent({@required this.card, this.counter = 0});

  @override
  List<StateChange> apply(GameState state) {
    if (card is IOnEnterField) {
      // If no valid effects are left
      if (counter == (card as IOnEnterField).onEnterFieldEffects.length) {
        return [RemoveStackEventStateChange(event: this)];
      }
      // Return the next effect and increment
      else {
        return [
          AddStackEventStateChange(
              event: (card as IOnEnterField).onEnterFieldEffects[counter]),
          IncrementStackEventStateChange(event: this),
        ];
      }
    } else {
      return [RemoveStackEventStateChange(event: this)];
    }
  }

  @override
  OnCardEnterFieldEvent get increment =>
      OnCardEnterFieldEvent(card: card, counter: counter + 1);

  @override
  List<Object> get props => [card, counter];
}
