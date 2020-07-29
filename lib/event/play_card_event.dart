import 'package:hexal_engine/state_change/resolve_event_state_change.dart';
import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../objects/card_object.dart';
import '../state_change/combination/put_into_field_state_changes.dart';
import '../state_change/state_change.dart';
import 'event.dart';

class PlayCardEvent extends Event {
  final CardObject card;

  const PlayCardEvent({@required this.card, bool resolved = false})
      : super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    return [
      ...PutIntoFieldStateChanges.generate(card),
      ResolveEventStateChange(event: this)
    ];
  }

  @override
  PlayCardEvent get copyResolved => PlayCardEvent(card: card, resolved: true);

  @override
  List<Object> get props => [card, resolved];
}
