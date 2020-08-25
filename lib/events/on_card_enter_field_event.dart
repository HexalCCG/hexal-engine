import '../cards/i_on_enter_field.dart';
import '../models/card_object.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/modify_event_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'event.dart';

/// Effect caused by a card entering the field.
class OnCardEnterFieldEvent extends Event {
  /// Card whose effects are being applied.
  final CardObject card;

  /// Index of effect currently being applied.
  final int effectIndex;

  /// [Card] is the card entering the field.
  /// [effectIndex] is the effect currently being resolved.
  const OnCardEnterFieldEvent(
      {required this.card, this.effectIndex = 0, bool resolved = false})
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