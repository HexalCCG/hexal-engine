import '../effect/effect.dart';
import '../effect/i_targeted.dart';
import '../effect/target/target.dart';
import '../exceptions/event_exceptipn.dart';
import '../game_state/game_state.dart';
import '../state_change/state_change.dart';
import 'event.dart';

/// Requests a target from a player for an effect.
class RequestTargetEvent extends Event {
  /// The effect to be filled.
  final Effect effect;

  /// Target the result must conform to.
  final Target target;

  /// [Effect] to be filled, and its [target] pattern.
  const RequestTargetEvent({
    required this.effect,
    required this.target,
    bool resolved = false,
  })  : assert(effect is ITargetted),
        super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    throw const EventException(
        'RequestTargetEvent error: This should never be applied');
  }

  @override
  RequestTargetEvent get copyResolved =>
      RequestTargetEvent(effect: effect, target: target, resolved: true);

  @override
  List<Object> get props => [effect, target, resolved];
}
