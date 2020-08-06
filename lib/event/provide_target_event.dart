import 'package:hexal_engine/effect/i_targeted.dart';
import 'package:hexal_engine/effect/target/target.dart';
import 'package:hexal_engine/exceptions/event_exception.dart';
import 'package:hexal_engine/state_change/fill_request_state_change.dart';
import 'package:hexal_engine/state_change/modify_event_state_change.dart';
import 'package:hexal_engine/state_change/resolve_event_state_change.dart';
import 'package:meta/meta.dart';

import '../effect/effect.dart';
import '../game_state/game_state.dart';
import '../state_change/state_change.dart';
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
  })  : assert(effect is ITargetted),
        super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    return [
      ModifyEventStateChange(
        event: effect,
        newEvent: (effect as ITargetted).copyWithTarget(targetResult),
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
