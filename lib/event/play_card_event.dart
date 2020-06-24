import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../objects/card_object.dart';
import '../state_change/state_change.dart';
import 'event.dart';

class PlayCardEvent extends Event {
  final CardObject card;

  const PlayCardEvent({@required this.card});

  @override
  List<StateChange> apply(GameState state) {
    throw UnimplementedError();
  }

  @override
  List<Object> get props => [card];
}
