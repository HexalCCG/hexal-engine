import '../effects/effect.dart';
import '../effects/i_targeted.dart';
import '../effects/target/target.dart';
import '../models/game_state.dart';
import '../state_changes/modify_event_state_change.dart';
import '../state_changes/resolve_event_state_change.dart';
import '../state_changes/state_change.dart';
import 'event.dart';

/// Provides a target to the preceding effect.
class ProvideTargetEvent extends Event {
  /// Effect to provide the target to.
  final Effect effect;

  /// The targetresult derived from player input.
  final TargetResult targetResult;

  /// Fields copied from the RequestTargetEvent this replaces.
  const ProvideTargetEvent({
    required this.effect,
    required this.targetResult,
    bool resolved = false,
  })  : assert(effect is ITargeted),
        super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    return [
      ModifyEventStateChange(
        event: effect,
        newEvent: (effect as ITargeted).copyWithTarget(targetResult),
      ),
      ResolveEventStateChange(event: this),
    ];
  }

  @override
  ProvideTargetEvent get copyResolved => ProvideTargetEvent(
      effect: effect, targetResult: targetResult, resolved: true);

  @override
  List<Object> get props => [effect, targetResult, resolved];
}
