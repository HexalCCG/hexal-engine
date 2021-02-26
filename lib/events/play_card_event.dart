import '../card/on_enter_field.dart';
import '../models/enums/location.dart';
import '../models/game_state.dart';
import '../models/mana_amount.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/modify_event_state_change.dart';
import '../state_changes/put_into_field_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'destroy_card_event.dart';
import 'event.dart';
import 'on_card_enter_field_event.dart';
import 'require_mana_event.dart';

/// Stages the play card event processes.
enum PlayCardEventStage {
  /// Before requesting mana or entering field.
  init,

  /// After mana is requested but before entering field.
  doneRequestMana,

  /// After mana and entering field are done.
  donePutIntoField,
}

/// Event to play a card from hand.
class PlayCardEvent extends Event {
  /// Card to play.
  final int card;

  /// Stage of playing the card to process.
  final PlayCardEventStage stage;

  @override
  final bool resolved;

  /// [card] is put into the field.
  const PlayCardEvent({
    required this.card,
    this.stage = PlayCardEventStage.init,
    this.resolved = false,
  });

  @override
  bool valid(GameState state) {
    // Check card exists and isn't a player.
    final _card = state.getCardById(card);

    // Before put into field card must be in limbo.
    if (stage != PlayCardEventStage.donePutIntoField &&
        _card.location != Location.limbo) {
      return false;
    }
    // After put into field card must be in field.
    if (stage == PlayCardEventStage.donePutIntoField &&
        _card.location != Location.field) {
      return false;
    }

    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      return [ResolveEventStateChange(event: this)];
    }

    final _card = state.getCardById(card);
    final _cardRequiresMana = _card.manaCost != const ManaAmount.zero();

    // If we haven't requested mana and we need to, do that.
    if (stage == PlayCardEventStage.init && _cardRequiresMana) {
      return [
        AddEventStateChange(
            event: RequireManaEvent(card: card, cost: _card.manaCost)),
        ModifyEventStateChange(
            event: this,
            newEvent: _copyAtStage(PlayCardEventStage.doneRequestMana)),
      ];
    }

    // If card hasn't been put into field yet, do that.
    if (stage != PlayCardEventStage.donePutIntoField) {
      return [
        PutIntoFieldStateChange(card: card),
        ...(_card is OnEnterField)
            ? [AddEventStateChange(event: OnCardEnterFieldEvent(card: card))]
            : [],
        ModifyEventStateChange(
            event: this,
            newEvent: _copyAtStage(PlayCardEventStage.donePutIntoField)),
      ];
    }

    // If it's in play, destroy it if it's not permanent
    // Regardless, resolve.
    if (_card.permanent) {
      return [ResolveEventStateChange(event: this)];
    } else {
      return [
        AddEventStateChange(event: DestroyCardEvent(card: card)),
        ResolveEventStateChange(event: this),
      ];
    }
  }

  PlayCardEvent _copyAtStage(PlayCardEventStage stage) =>
      PlayCardEvent(card: card, stage: stage, resolved: resolved);

  @override
  PlayCardEvent get copyResolved =>
      PlayCardEvent(card: card, stage: stage, resolved: true);

  @override
  List<Object> get props => [card, stage, resolved];

  /// Create this event from json.
  static PlayCardEvent fromJson(List<dynamic> json) => PlayCardEvent(
      card: json[0] as int,
      stage: PlayCardEventStage.values[json[1] as int],
      resolved: json[2] as bool);
}
