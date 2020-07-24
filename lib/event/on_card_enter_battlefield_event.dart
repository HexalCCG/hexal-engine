import 'package:hexal_engine/event/event.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/state_change/state_change.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:meta/meta.dart';

/// Effect caused by a card entering the battlefield.
class OnCardEnterBattleFieldEvent extends Event {
  final CardObject card;

  const OnCardEnterBattleFieldEvent({@required this.card});

  @override
  List<StateChange> apply(GameState state) {
    // TODO: implement apply
    throw UnimplementedError();
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
