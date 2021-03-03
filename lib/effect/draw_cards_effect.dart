import '../event/draw_cards_event.dart';
import '../model/enums/event_state.dart';
import '../model/enums/player.dart';
import '../model/game_state.dart';
import '../state_change/state_change.dart';
import 'effect.dart';

/// Deals damage to a target.
class DrawCardsEffect extends DrawCardsEvent with Effect {
  /// [target] is target to request. [targetResult] returns from the request.
  /// [targetIndex] counts through list of targets to apply damage.
  const DrawCardsEffect({
    int id = 0,
    EventState state = EventState.unresolved,
    required int draws,
    required Player player,
  }) : super(id: id, state: state, draws: draws, player: player);

  @override
  bool valid(GameState state) => super.valid(state);

  @override
  List<StateChange> apply(GameState state) => super.apply(state);

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
