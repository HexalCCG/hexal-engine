import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../state_change/state_change.dart';

// Actions represent user inputs.
@immutable
abstract class Action extends Equatable {
  const Action();

  List<StateChange> apply(GameState state);

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
