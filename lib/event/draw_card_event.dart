import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../game_state/player.dart';
import '../state_change/state_change.dart';
import 'event.dart';

class DrawCardEvent extends Event {
  final Player player;

  const DrawCardEvent({@required this.player});

  @override
  List<StateChange> apply(GameState state) {
    // TODO: implement apply
    //throw UnimplementedError();
    return [];
  }

  @override
  List<Object> get props => [player];
}
