import '../event/event.dart';
import '../game_state/game_state.dart';
import '../game_state/player.dart';
import '../state_change/state_change.dart';

/// Empty effect.
abstract class Effect extends Event {
  /// Player than controls this effect and will provide targets.
  final Player controller;

  /// Empty effect.
  const Effect({required this.controller, required bool resolved})
      : super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state);

  @override
  List<Object> get props;

  @override
  bool get stringify => true;
}
