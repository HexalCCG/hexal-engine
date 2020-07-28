import '../event/event.dart';
import '../game_state/game_state.dart';
import '../state_change/state_change.dart';

abstract class Effect extends Event {
  const Effect();

  @override
  List<StateChange> apply(GameState state);

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
