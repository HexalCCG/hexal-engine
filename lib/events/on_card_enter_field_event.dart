import '../cards/i_on_enter_field.dart';
import '../models/enums/location.dart';
import '../models/game_object_reference.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/modify_event_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'event.dart';

/// Effect caused by a card entering the field.
class OnCardEnterFieldEvent extends Event {
  /// Card whose effects are being applied.
  final GameObjectReference card;

  /// Index of effect currently being applied.
  final int effectIndex;

  @override
  final bool resolved;

  /// [Card] is the card entering the field.
  /// [effectIndex] is the effect currently being resolved.
  const OnCardEnterFieldEvent(
      {required this.card, this.effectIndex = 0, this.resolved = false});

  @override
  bool valid(GameState state) {
    final _card = state.getCardById(card.id);

    // Card must be in the field.
    if (_card.location != Location.field) {
      return false;
    }

    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {}

    final _card = state.getCardById(card.id);

    // If the card has no enter field effects, resolve this.
    if (!(_card is IOnEnterField)) {
      return [ResolveEventStateChange(event: this)];
    }

    // If only one effect is left, do it and resolve
    if (effectIndex ==
        (_card as IOnEnterField).onEnterFieldEffects.length - 1) {
      return [
        AddEventStateChange(
            event: (_card as IOnEnterField).onEnterFieldEffects[effectIndex]),
        ResolveEventStateChange(event: this),
      ];
    }

    // Otherwise do the effect and increment
    return [
      AddEventStateChange(
          event: (_card as IOnEnterField).onEnterFieldEffects[effectIndex]),
      ModifyEventStateChange(event: this, newEvent: _copyIncremented),
    ];
  }

  OnCardEnterFieldEvent get _copyIncremented => OnCardEnterFieldEvent(
      card: card, effectIndex: effectIndex + 1, resolved: resolved);

  @override
  OnCardEnterFieldEvent get copyResolved => OnCardEnterFieldEvent(
      card: card, effectIndex: effectIndex, resolved: true);

  @override
  List<Object> get props => [card, effectIndex, resolved];

  factory OnCardEnterFieldEvent.fromJson(List<dynamic> json) =>
      OnCardEnterFieldEvent(
          card: GameObjectReference.fromJson(json[0] as int),
          effectIndex: json[1] as int,
          resolved: json[2] as bool);
}
