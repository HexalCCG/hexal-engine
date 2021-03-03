import '../../card/hero.dart';
import '../../card/on_trigger.dart';
import '../../effect/draw_cards_effect.dart';
import '../../effect/trigger/on_summon_elemental_creature.dart';
import '../../effect/trigger/triggered_effect.dart';
import '../../card/card.dart';
import '../../model/card_identity.dart';
import '../../model/enums/element.dart';
import '../../model/enums/location.dart';
import '../../model/enums/player.dart';
import '../../model/mana_amount.dart';

/// Earth Hero. "When you summon an [Earth] creature, draw a card".
class HivequeenNgaat extends Card with Hero, OnTrigger {
  @override
  CardIdentity get identity => const CardIdentity(1, 0);

  @override
  Element get element => Element.earth;

  @override
  ManaAmount get manaCost => const ManaAmount(earth: 4);

  @override
  List<TriggeredEffect> get onTriggerEffects => [
        TriggeredEffect(
          trigger: onSummonFriendlyElementalCreature(this, Element.earth, 0),
          effectBuilder: (state) =>
              DrawCardsEffect(draws: 1, player: controller),
          historyBuilder:
              onSummonFriendlyElementalCreatureHistory(this, Element.earth, 0),
          optional: false,
        )
      ];

  /// Earth Hero. "When you summon an [Earth] creature, draw a card".
  const HivequeenNgaat({
    int id = 0,
    Player owner = Player.one,
    Player controller = Player.one,
    Location location = Location.deck,
  }) : super(
          id: id,
          owner: owner,
          controller: controller,
          location: location,
        );

  @override
  HivequeenNgaat copyWith({
    int? id,
    Player? owner,
    Player? controller,
    Location? location,
  }) =>
      HivequeenNgaat(
        id: id ?? this.id,
        owner: owner ?? this.owner,
        controller: controller ?? this.controller,
        location: location ?? this.location,
      );
}
