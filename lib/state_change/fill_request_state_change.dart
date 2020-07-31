import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/state_change/modify_event_state_change.dart';
import 'package:meta/meta.dart';

import '../effect/target/target.dart';
import '../event/request_target_event.dart';
import 'state_change.dart';

class FillRequestStateChange extends StateChange {
  final RequestTargetEvent request;
  final TargetResult targetResult;

  const FillRequestStateChange(
      {@required this.request, @required this.targetResult});

  @override
  GameState apply(GameState state) => ModifyEventStateChange(
          event: request, newEvent: request.copyWithResult(targetResult))
      .apply(state);

  @override
  List<Object> get props => [request, targetResult];
}
