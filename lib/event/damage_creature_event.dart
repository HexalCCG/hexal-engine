import 'package:meta/meta.dart';

import '../game_state/game_state.dart';
import '../objects/card_object.dart';
import '../state_change/damage_creature_state_change.dart';
import '../state_change/resolve_event_state_change.dart';
import '../state_change/state_change.dart';
import 'event.dart';

class DamageCreatureEvent extends Event {
  final CardObject card;
  final int damage;

  const DamageCreatureEvent(
      {@required this.card, @required this.damage, bool resolved = false})
      : super(resolved: resolved);

  @override
  List<StateChange> apply(GameState state) {
    return [
      DamageCreatureStateChange(card: card, damage: damage),
      ResolveEventStateChange(event: this),
    ];
  }

  @override
  DamageCreatureEvent get copyResolved =>
      DamageCreatureEvent(card: card, damage: damage, resolved: true);

  @override
  List<Object> get props => [card, damage, resolved];
}
