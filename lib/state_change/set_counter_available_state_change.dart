import '../game_state/game_state.dart';
import 'state_change.dart';

/// Changes whether counter phase is enabled for this turn.
class SetCounterAvailableStateChange extends StateChange {
  /// Bool to set the GameState's counterAvailable flag to.
  final bool enabled;

  /// [Enabled] changes the game state's counterAvailable flag.
  const SetCounterAvailableStateChange({required this.enabled});

  @override
  GameState apply(GameState state) {
    return state.copyWith(counterAvailable: enabled);
  }

  @override
  List<Object> get props => [enabled];
}
