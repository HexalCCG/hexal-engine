import 'package:meta/meta.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/state_change/state_change.dart';

class MoveCardStateChange extends StateChange {
  final CardObject card;
  final Location location;

  const MoveCardStateChange({@required this.card, @required this.location});

  @override
  GameState apply(GameState state) {
    // TODO: implement apply
    throw UnimplementedError();
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
