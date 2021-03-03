import '../../card/on_enter_field.dart';
import '../../card/spell.dart';
import '../../effects/damage_effect.dart';
import '../../effects/effect.dart';
import '../../effects/target/creature_target.dart';
import '../../card/card.dart';
import '../../models/card_identity.dart';
import '../../models/enums/element.dart';
import '../../models/enums/location.dart';
import '../../models/enums/player.dart';

/// 0 cost spell. Deal 1 damage to a creature.
class CowBeamCard extends Card with Spell, OnEnterField {
  @override
  CardIdentity get identity => const CardIdentity(0, 2);

  @override
  Element get element => Element.earth;

  /// [id] must be unique. [owner] cannot be changed.
  const CowBeamCard({
    int id = 0,
    Player owner = Player.one,
    Player controller = Player.one,
    Location location = Location.deck,
  }) : super(id: id, owner: owner, controller: controller, location: location);

  // OnEnterField
  @override
  List<Effect> get onEnterFieldEffects => [
        DamageEffect(
          damage: 1,
          target: CreatureTarget(
            controller: controller,
          ),
          controller: controller,
        )
      ];

  @override
  CowBeamCard copyWith(
          {int? id, Player? owner, Player? controller, Location? location}) =>
      CowBeamCard(
          id: id ?? this.id,
          owner: owner ?? this.owner,
          controller: controller ?? this.controller,
          location: location ?? this.location);
}
