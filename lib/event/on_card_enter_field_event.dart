import '../card/on_enter_field.dart';
import '../model/enums/event_state.dart';
import '../model/enums/location.dart';
import '../model/game_state.dart';
import '../state_change/add_event_state_change.dart';
import '../state_change/modify_event_state_change.dart';
import '../state_change/resolve_event_state_change.dart';
import '../state_change/state_change.dart';
import 'event.dart';

/// Effect caused by a card entering the field.
class OnCardEnterFieldEvent extends Event {
  /// Card whose effects are being applied.
  final int card;

  /// Index of effect currently being applied.
  final int effectIndex;

  /// [Card] is the card entering the field.
  /// [effectIndex] is the effect currently being resolved.
  const OnCardEnterFieldEvent({
    int id = 0,
    EventState state = EventState.unresolved,
    required this.card,
    this.effectIndex = 0,
  }) : super(id: id, state: state);

  @override
  bool valid(GameState state) {
    final _card = state.getCardById(card);

    // Card must be in the field.
    if (_card.location != Location.field) {
      return false;
    }
    // Card must have an onEnterField effect
    if (_card is! OnEnterField) {
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

    final _card = state.getCardById(card) as OnEnterField;

    // If only one effect is left, do it and resolve
    if (effectIndex == _card.onEnterFieldEffects.length - 1) {
      return [
        AddEventStateChange(event: _card.onEnterFieldEffects[effectIndex]),
        ResolveEventStateChange(event: this, eventState: EventState.succeeded),
      ];
    }

    // Otherwise do the effect and increment
    return [
      AddEventStateChange(event: _card.onEnterFieldEffects[effectIndex]),
      ModifyEventStateChange(event: this, newEvent: _copyIncremented),
    ];
  }

  OnCardEnterFieldEvent get _copyIncremented =>
      OnCardEnterFieldEvent(id: id, card: card, effectIndex: effectIndex + 1);

  @override
  OnCardEnterFieldEvent copyWith({int? id, EventState? state}) =>
      OnCardEnterFieldEvent(
          id: id ?? this.id,
          state: state ?? this.state,
          card: card,
          effectIndex: effectIndex);

  @override
  List<Object> get props => [id, state, card, effectIndex];

  /// Create this event from json.
  static OnCardEnterFieldEvent fromJson(List<dynamic> json) =>
      OnCardEnterFieldEvent(
        id: json[0] as int,
        state: EventState.fromIndex(json[1] as int),
        card: json[2] as int,
        effectIndex: json[3] as int,
      );
}
