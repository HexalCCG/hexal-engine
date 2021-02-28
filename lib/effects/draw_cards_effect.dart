import '../events/draw_cards_event.dart';
import '../events/event.dart';
import '../models/enums/event_state.dart';
import '../models/enums/player.dart';
import '../models/game_state.dart';
import '../state_changes/add_event_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'effect.dart';

/// Deals damage to a target.
class DrawCardsEffect extends Event with Effect {
  /// Number of cards to draw.
  final int draws;

  /// Player who draws the cards.
  final Player player;

  /// [target] is target to request. [targetResult] returns from the request.
  /// [targetIndex] counts through list of targets to apply damage.
  const DrawCardsEffect({
    int id = 0,
    EventState state = EventState.unresolved,
    required this.draws,
    required this.player,
  }) : super(id: id, state: state);

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
      AddEventStateChange(event: DrawCardsEvent(player: player, draws: draws)),
      ResolveEventStateChange(event: this)
    ];
  }

  @override
  DrawCardsEffect copyWith({int? id, EventState? state}) => DrawCardsEffect(
      id: id ?? this.id,
      state: state ?? this.state,
      draws: draws,
      player: player);

  @override
  List<Object> get props => [
        id,
        state,
        draws,
        player,
      ];

  /// Create this effect from json.
  static DrawCardsEffect fromJson(List<dynamic> json) => DrawCardsEffect(
        id: json[0] as int,
        state: EventState.fromIndex(json[1] as int),
        draws: json[2] as int,
        player: Player.fromIndex(json[3] as int),
      );
}
