import 'package:equatable/equatable.dart';

import '../game_state.dart';

abstract class StateChange extends Equatable {
  const StateChange();

  GameState apply(GameState state);

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
