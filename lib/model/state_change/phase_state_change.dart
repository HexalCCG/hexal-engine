import 'package:hexal_engine/model/game_state.dart';
import 'package:meta/meta.dart';
import 'package:hexal_engine/model/state_change/state_change.dart';
import '../turn_phase.dart';

class PhaseStateChange extends StateChange {
  final TurnPhase phase;
  const PhaseStateChange({@required this.phase});

  @override
  List<Object> get props => [phase];

  @override
  GameState apply(GameState state) {
    return state.copyWith(turnPhase: phase);
  }
}
