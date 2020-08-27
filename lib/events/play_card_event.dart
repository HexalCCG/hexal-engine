import '../cards/i_on_enter_field.dart';
import '../models/enums/location.dart';
import '../models/game_object_reference.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/modify_event_state_change.dart';
import '../state_changes/put_into_field_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'destroy_card_event.dart';
import 'event.dart';
import 'on_card_enter_field_event.dart';

/// Event to play a card from hand.
class PlayCardEvent extends Event {
  /// Card to play.
  final GameObjectReference card;

  /// Whether the card has been put into the field yet.
  final bool donePutIntoField;

  @override
  final bool resolved;

  /// [card] is put into the field.
  const PlayCardEvent(
      {required this.card,
      this.donePutIntoField = false,
      this.resolved = false});

  @override
  bool valid(GameState state) {
    // Check card exists and isn't a player.
    final _card = state.getCardById(card.id);

    // Before put into field card must be in limbo.
    if (!donePutIntoField && _card.location != Location.limbo) {
      return false;
    }
    // After put into field card must be in field.
    if (donePutIntoField && _card.location != Location.field) {
      return false;
    }

    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      return [ResolveEventStateChange(event: this)];
    }

    final _card = state.getCardById(card.id);

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
      if (_card.permanent) {
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
  List<Object> get props => [card, donePutIntoField, resolved];

  factory PlayCardEvent.fromJson(List<dynamic> json) => PlayCardEvent(
      card: GameObjectReference.fromJson(json[0] as int),
      donePutIntoField: json[1] as bool,
      resolved: json[2] as bool);
}
