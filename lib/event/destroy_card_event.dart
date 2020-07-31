import 'package:hexal_engine/event/event.dart';
import 'package:hexal_engine/game_state/game_state.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/objects/card_object.dart';
import 'package:hexal_engine/state_change/move_card_state_change.dart';
import 'package:hexal_engine/state_change/state_change.dart';
import 'package:meta/meta.dart';

class DestroyCardEvent extends Event {
  final CardObject card;

  const DestroyCardEvent({
    @required this.card,
    bool resolved = false,
  })  : assert(card != null),
        super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) =>
      [MoveCardStateChange(card: card, location: Location.mana)];

  @override
  DestroyCardEvent get copyResolved => DestroyCardEvent(
        card: card,
        resolved: true,
      );

  @override
  List<Object> get props => [card, resolved];
}
