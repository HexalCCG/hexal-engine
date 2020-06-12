import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../objects/player_object.dart';
import '../state_change/state_change.dart';
import 'event.dart';

class DrawCardEvent extends Event {
  final PlayerObject player;

  const DrawCardEvent({@required this.player});

  @override
  List<StateChange> apply(GameState state) {
    // TODO: implement apply
    throw UnimplementedError();
  }

  @override
  List<Object> get props => [player];
}
