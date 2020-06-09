import 'package:equatable/equatable.dart';
import '../state_change/state_change.dart';
import 'package:meta/meta.dart';

import '../game_state.dart';

@immutable
abstract class Action extends Equatable {
  const Action();

  @override
  List<Object> get props;

  @override
  bool get stringify => true;

  List<StateChange> apply(GameState state);
}
