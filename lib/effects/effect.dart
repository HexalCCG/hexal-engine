import '../events/event.dart';
import '../models/enums/player.dart';
import '../models/game_state.dart';
import '../state_changes/state_change.dart';

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
