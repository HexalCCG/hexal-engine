import 'package:hexal_engine/effect/target/target.dart';
import 'package:meta/meta.dart';

import '../effect/effect.dart';
import '../game_state/game_state.dart';
import '../state_change/state_change.dart';
import 'event.dart';

class RequestTargetEvent extends Event {
  final Effect effect;
  final Target target;

  const RequestTargetEvent(
      {@required this.effect, @required this.target, bool resolved = false})
      : super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {}

  @override
  RequestTargetEvent get copyResolved =>
      RequestTargetEvent(effect: effect, target: target, resolved: true);

  @override
  List<Object> get props => [effect, target, resolved];
}
