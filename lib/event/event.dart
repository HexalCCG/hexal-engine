import 'package:equatable/equatable.dart';

import '../game_state/game_state.dart';
import '../state_change/state_change.dart';

abstract class Event extends Equatable {
  const Event();

  List<StateChange> apply(GameState state);

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
