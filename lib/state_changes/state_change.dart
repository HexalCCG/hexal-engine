import '../extensions/equatable/equatable.dart';
import '../models/game_state.dart';

/// StateChanges are applied to the GameState to change it.
abstract class StateChange extends Equatable {
  /// Empty StateChange.
  const StateChange();

  /// Apply the StateChange to a state.
  GameState apply(GameState state);

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
