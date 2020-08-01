import 'package:hexal_engine/cards/mi_creature.dart';
import 'package:hexal_engine/event/destroy_card_event.dart';
import 'package:hexal_engine/state_change/add_event_state_change.dart';
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
    if ((card as ICreature).damage + damage > (card as ICreature).health) {
      return [
        DamageCreatureStateChange(card: card, damage: damage),
        ResolveEventStateChange(event: this),
        AddEventStateChange(event: DestroyCardEvent(card: card)),
      ];
    } else {
      return [
        DamageCreatureStateChange(card: card, damage: damage),
        ResolveEventStateChange(event: this),
      ];
    }
  }

  @override
  DamageCreatureEvent get copyResolved =>
      DamageCreatureEvent(card: card, damage: damage, resolved: true);

  @override
  List<Object> get props => [card, damage, resolved];
}
