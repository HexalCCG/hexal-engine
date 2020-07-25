import 'package:equatable/equatable.dart';

import '../event/event.dart';
import '../game_state/game_state.dart';

abstract class Effect extends Equatable {
  const Effect();

  List<Event> apply(GameState state);

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
