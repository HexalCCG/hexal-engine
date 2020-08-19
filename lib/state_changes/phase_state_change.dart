import '../models/game_state.dart';
import '../models/turn_phase.dart';
import 'state_change.dart';

/// StateChange to change the turn phase.
class PhaseStateChange extends StateChange {
  /// Phase to set state to.
  final TurnPhase phase;

  /// Set turn phase to [phase].
  const PhaseStateChange({required this.phase});

  @override
  GameState apply(GameState state) {
    return state.copyWith(turnPhase: phase);
  }

  @override
  List<Object> get props => [phase];
}
