import '../events/draw_cards_event.dart';
import '../models/enums/player.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'effect.dart';

/// Deals damage to a target.
class DrawCardsEffect extends Effect {
  /// Number of cards to draw.
  final int draws;

  @override
  final Player controller;

  /// [target] is target to request. [targetResult] returns from the request.
  /// [targetIndex] counts through list of targets to apply damage.
  const DrawCardsEffect({
    int id = 0,
    required this.draws,
    required this.controller,
  }) : super(id: id);

  @override
  bool valid(GameState state) {
    return true;
  }

  @override
  List<StateChange> apply(GameState state) {
    if (!valid(state)) {
      return [ResolveEventStateChange(event: this)];
    }

    if (draws <= 0) {
      // If there are no targets, resolve this.
      return [ResolveEventStateChange(event: this)];
    }

    // Replace this with a draw cards event.
    return [
      AddEventStateChange(
          event: DrawCardsEvent(player: controller, draws: draws)),
      ResolveEventStateChange(event: this)
    ];
  }

  @override
  DrawCardsEffect copyWithId(int id) =>
      DrawCardsEffect(id: id, draws: draws, controller: controller);

  @override
  List<Object> get props => [
        id,
        draws,
        controller,
      ];

  /// Create this effect from json.
  static DrawCardsEffect fromJson(List<dynamic> json) => DrawCardsEffect(
        id: json[0] as int,
        draws: json[1] as int,
        controller: Player.fromIndex(json[2] as int),
      );
}
