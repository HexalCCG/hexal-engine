import '../models/enums/event_state.dart';
import '../models/enums/location.dart';
import '../models/game_state.dart';
import '../models/mana_amount.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/modify_event_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'cast_card_event.dart';
import 'destroy_card_event.dart';
import 'event.dart';
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

  /// [card] is put into the field.
  const PlayCardEvent({
    int id = 0,
    EventState state = EventState.unresolved,
    required this.card,
    this.stage = PlayCardEventStage.init,
  }) : super(id: id, state: state);

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
      return [
        ResolveEventStateChange(event: this, eventState: EventState.failed)
      ];
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
        AddEventStateChange(event: CastCardEvent(card: card)),
        ModifyEventStateChange(
            event: this,
            newEvent: _copyAtStage(PlayCardEventStage.donePutIntoField)),
      ];
    }

    // If it's in play, destroy it if it's not permanent
    // Regardless, resolve.
    if (_card.permanent) {
      return [
        ResolveEventStateChange(event: this, eventState: EventState.succeeded)
      ];
    } else {
      return [
        AddEventStateChange(event: DestroyCardEvent(card: card)),
        ResolveEventStateChange(event: this, eventState: EventState.succeeded),
      ];
    }
  }

  PlayCardEvent _copyAtStage(PlayCardEventStage stage) =>
      PlayCardEvent(id: id, card: card, stage: stage);

  @override
  PlayCardEvent copyWith({int? id, EventState? state}) => PlayCardEvent(
      id: id ?? this.id, state: state ?? this.state, card: card, stage: stage);

  @override
  List<Object> get props => [id, state, card, stage];

  /// Create this event from json.
  static PlayCardEvent fromJson(List<dynamic> json) => PlayCardEvent(
        id: json[0] as int,
        state: EventState.fromIndex(json[1] as int),
        card: json[2] as int,
        stage: PlayCardEventStage.values[json[3] as int],
      );
}
