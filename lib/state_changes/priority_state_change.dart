import '../models/enums/player.dart';
import '../models/game_state.dart';
import 'state_change.dart';

/// StateChange to change priority.
class PriorityStateChange extends StateChange {
  /// Player to make priority player.
  final Player player;

  /// Sets priority to [player].
  const PriorityStateChange({required this.player});

  @override
  GameState apply(GameState state) {
    return state.copyWith(priorityPlayer: player);
  }

  @override
  List<Object> get props => [player];
}
