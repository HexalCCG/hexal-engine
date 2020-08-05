import 'package:meta/meta.dart';

import '../cards/i_on_enter_field.dart';
import '../cards/i_permanent.dart';
import '../game_state/game_state.dart';
import '../objects/card_object.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/modify_event_state_change.dart';
import '../state_change/put_into_field_state_change.dart';
import '../state_change/resolve_event_state_change.dart';
import '../state_change/state_change.dart';
import 'destroy_card_event.dart';
import 'event.dart';
import 'on_card_enter_field_event.dart';

class PlayCardEvent extends Event {
  final CardObject card;
  final bool donePutIntoField;

  const PlayCardEvent(
      {@required this.card,
      this.donePutIntoField = false,
      bool resolved = false})
      : super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    // If card hasn't been put into field yet, do that.
    if (!donePutIntoField) {
      return [
        PutIntoFieldStateChange(card: card),
        ...(card is IOnEnterField)
            ? [AddEventStateChange(event: OnCardEnterFieldEvent(card: card))]
            : [],
        ModifyEventStateChange(event: this, newEvent: _copyDonePutIntoField),
      ];
      // If it's in play, destroy it if it's not permanent
    } else {
      if (card is IPermanent) {
        return [ResolveEventStateChange(event: this)];
      } else {
        return [
          AddEventStateChange(event: DestroyCardEvent(card: card)),
          ResolveEventStateChange(event: this),
        ];
      }
    }
  }

  PlayCardEvent get _copyDonePutIntoField =>
      PlayCardEvent(card: card, donePutIntoField: true, resolved: resolved);

  @override
  PlayCardEvent get copyResolved => PlayCardEvent(
      card: card, donePutIntoField: donePutIntoField, resolved: true);

  @override
  List<Object> get props => [card, resolved];
}
