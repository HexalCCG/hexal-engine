import 'package:hexal_engine/effect/i_targetted.dart';
import 'package:hexal_engine/effect/target/target.dart';
import 'package:hexal_engine/exceptions/event_exceptipn.dart';
import 'package:hexal_engine/state_change/fill_request_state_change.dart';
import 'package:hexal_engine/state_change/modify_event_state_change.dart';
import 'package:hexal_engine/state_change/resolve_event_state_change.dart';
import 'package:meta/meta.dart';

import '../effect/effect.dart';
import '../game_state/game_state.dart';
import '../state_change/state_change.dart';
import 'event.dart';

class RequestTargetEvent extends Event {
  final Effect effect;
  final Target target;
  final TargetResult targetResult;

  const RequestTargetEvent({
    @required this.effect,
    @required this.target,
    this.targetResult,
    bool resolved = false,
  })  : assert(effect is ITargetted),
        super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    if (targetResult == null) {
      throw const EventException(
          'RequestTargetEvent error: TargetResult should not be null');
    }
    return [
      ModifyEventStateChange(
        event: effect,
        newEvent: (effect as ITargetted).copyWithTarget(targetResult),
      ),
      ResolveEventStateChange(event: this),
    ];
  }

  List<StateChange> createFillStateChange(dynamic input) {
    return [
      FillRequestStateChange(
          request: this, targetResult: target.createResult(input)),
    ];
  }

  List<StateChange> get emptyFillStateChange => [
        FillRequestStateChange(
            request: this, targetResult: EmptyTargetResult()),
      ];

  RequestTargetEvent copyWithResult(TargetResult result) => RequestTargetEvent(
      effect: effect, target: target, targetResult: result, resolved: resolved);

  @override
  RequestTargetEvent get copyResolved => RequestTargetEvent(
      effect: effect,
      target: target,
      targetResult: targetResult,
      resolved: true);

  @override
  List<Object> get props => [effect, target, targetResult, resolved];
}
