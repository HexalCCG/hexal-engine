import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../state_change/state_change.dart';

@immutable
abstract class Action extends Equatable {
  const Action();

  @override
  List<Object> get props;

  @override
  bool get stringify => true;

  List<StateChange> apply(GameState state);
}
