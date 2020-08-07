import 'package:meta/meta.dart';

import '../extensions/equatable/equatable.dart';
import '../game_state/game_state.dart';
import '../state_change/state_change.dart';

/// Actions represent user inputs.
@immutable
abstract class Action extends Equatable {
  /// Empty action.
  const Action();

  /// Whether this action is valid on the provided state.
  bool valid(GameState state);

  /// Generate state changes representing this action's effects on the state.
  List<StateChange> apply(GameState state);

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
