import '../card/on_enter_field.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/modify_event_state_change.dart';
import '../state_changes/put_into_field_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'destroy_card_event.dart';
import 'event.dart';
import 'on_card_enter_field_event.dart';

/// Cast a spell or summon a creature.
class CastCardEvent extends Event {
  /// Card to put into field.
  final int card;

  /// Has the card been put into field.
  final bool donePutIntoField;

  /// Spell to cast.
  const CastCardEvent({
    required this.card,
    this.donePutIntoField = false,
    int id = 0,
    bool resolved = false,
  }) : super(id: id, resolved: resolved);

  @override
  bool valid(GameState state) {
    // Check card exists and isn't a player.
    // If not it's an error so we let it throw.
    state.getCardById(card);

    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      return [ResolveEventStateChange(event: this)];
    }

    final _card = state.getCardById(card);

    if (!donePutIntoField) {
      return [
        PutIntoFieldStateChange(card: card),
        if (_card is OnEnterField)
          AddEventStateChange(event: OnCardEnterFieldEvent(card: card)),
        ModifyEventStateChange(event: this, newEvent: copyDonePutIntoField)
      ];
    } else {
      return [
        if (!_card.permanent)
          AddEventStateChange(event: DestroyCardEvent(card: card)),
        ResolveEventStateChange(event: this),
      ];
    }
  }

  @override
  CastCardEvent get copyResolved => CastCardEvent(
      card: card, donePutIntoField: donePutIntoField, resolved: true);

  /// Returns a copy of this with donePutIntoField set to true.
  CastCardEvent get copyDonePutIntoField =>
      CastCardEvent(card: card, donePutIntoField: true, resolved: resolved);

  @override
  List<Object> get props => [card, donePutIntoField, resolved];
}
