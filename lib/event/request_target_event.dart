import 'package:meta/meta.dart';

import '../effect/effect.dart';
import '../game_state/game_state.dart';
import '../state_change/state_change.dart';
import 'event.dart';

class RequestTargetEvent extends Event {
  final Effect effect;

  const RequestTargetEvent({@required this.effect, bool resolved = false})
      : super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {}

  @override
  RequestTargetEvent get copyResolved =>
      RequestTargetEvent(effect: effect, resolved: true);

  @override
  List<Object> get props => [effect, resolved];
}
