import 'package:hexal_engine/state_change/modify_event_state_change.dart';
import 'package:meta/meta.dart';

import '../cards/i_on_enter_field.dart';
import '../game_state/game_state.dart';
import '../objects/card_object.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/resolve_event_state_change.dart';
import '../state_change/state_change.dart';
import 'event.dart';

/// Effect caused by a card entering the field.
class OnCardEnterFieldEvent extends Event {
  final CardObject card;
  final int effectIndex;

  const OnCardEnterFieldEvent(
      {@required this.card, this.effectIndex = 0, bool resolved = false})
      : super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    if (!(card is IOnEnterField)) {
      // If the card has no enter field effects, resolve this.
      return [ResolveEventStateChange(event: this)];
    } else {
      // If only one effect is left, do it and resolve
      if (effectIndex ==
          (card as IOnEnterField).onEnterFieldEffects.length - 1) {
        return [
          AddEventStateChange(
              event: (card as IOnEnterField).onEnterFieldEffects[effectIndex]),
          ResolveEventStateChange(event: this),
        ];
      }
      // Otherwise do the effect and increment
      else {
        return [
          AddEventStateChange(
              event: (card as IOnEnterField).onEnterFieldEffects[effectIndex]),
          ModifyEventStateChange(event: this, newEvent: _copyIncremented),
        ];
      }
    }
  }

  OnCardEnterFieldEvent get _copyIncremented => OnCardEnterFieldEvent(
      card: card, effectIndex: effectIndex + 1, resolved: resolved);

  @override
  OnCardEnterFieldEvent get copyResolved => OnCardEnterFieldEvent(
      card: card, effectIndex: effectIndex, resolved: true);

  @override
  List<Object> get props => [card, effectIndex, resolved];
}
