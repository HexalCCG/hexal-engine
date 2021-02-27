import '../card/on_enter_field.dart';
import '../models/enums/location.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/modify_event_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
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
    required this.card,
    this.effectIndex = 0,
    int id = 0,
    bool resolved = false,
  }) : super(id: id, resolved: resolved);

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
      return [ResolveEventStateChange(event: this)];
    }

    final _card = state.getCardById(card) as OnEnterField;

    // If only one effect is left, do it and resolve
    if (effectIndex == _card.onEnterFieldEffects.length - 1) {
      return [
        AddEventStateChange(event: _card.onEnterFieldEffects[effectIndex]),
        ResolveEventStateChange(event: this),
      ];
    }

    // Otherwise do the effect and increment
    return [
      AddEventStateChange(event: _card.onEnterFieldEffects[effectIndex]),
      ModifyEventStateChange(event: this, newEvent: _copyIncremented),
    ];
  }

  OnCardEnterFieldEvent get _copyIncremented => OnCardEnterFieldEvent(
      id: id, card: card, effectIndex: effectIndex + 1, resolved: resolved);

  @override
  OnCardEnterFieldEvent copyWithId(int id) => OnCardEnterFieldEvent(
      id: id, card: card, effectIndex: effectIndex, resolved: resolved);

  @override
  OnCardEnterFieldEvent get copyResolved => OnCardEnterFieldEvent(
      id: id, card: card, effectIndex: effectIndex, resolved: true);

  @override
  List<Object> get props => [id, card, effectIndex, resolved];

  /// Create this event from json.
  static OnCardEnterFieldEvent fromJson(List<dynamic> json) =>
      OnCardEnterFieldEvent(
          id: json[0] as int,
          card: json[1] as int,
          effectIndex: json[2] as int,
          resolved: json[3] as bool);
}
