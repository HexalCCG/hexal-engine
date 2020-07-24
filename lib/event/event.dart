import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../state_change/state_change.dart';

/// Events are items placed on the stack to resolve.
@immutable
abstract class Event extends Equatable {
  const Event();

  List<StateChange> apply(GameState state);

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
