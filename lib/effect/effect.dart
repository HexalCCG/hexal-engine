import 'package:meta/meta.dart';

import '../event/event.dart';
import '../game_state/game_state.dart';
import '../state_change/state_change.dart';

abstract class Effect extends Event {
  const Effect({@required bool resolved}) : super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state);

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
