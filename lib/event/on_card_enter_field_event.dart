import 'package:hexal_engine/state_change/resolve_event_state_change.dart';
import 'package:meta/meta.dart';

import '../cards/i_on_enter_field.dart';
import '../game_state/game_state.dart';
import '../objects/card_object.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/increment_event_state_change.dart';
import '../state_change/remove_event_state_change.dart';
import '../state_change/state_change.dart';
import 'event.dart';
import 'i_incrementing.dart';

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
        return [ResolveEventStateChange(event: this)];
      }
      // Return the next effect and increment
      else {
        return [
          AddEventStateChange(
              event: (card as IOnEnterField).onEnterFieldEffects[counter]),
          IncrementEventStateChange(event: this),
        ];
      }
    } else {
      // If the card has no enter field effects, resolve this.
      return [ResolveEventStateChange(event: this)];
    }
  }

  @override
  OnCardEnterFieldEvent get increment =>
      OnCardEnterFieldEvent(card: card, counter: counter + 1);

  @override
  List<Object> get props => [card, counter];
}
