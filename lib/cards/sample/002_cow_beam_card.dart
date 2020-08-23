import '../../effects/damage_effect.dart';
import '../../effects/effect.dart';
import '../../effects/target/creature_target.dart';
import '../../models/card_object.dart';
import '../../models/location.dart';
import '../../models/player.dart';
import '../i_on_enter_field.dart';
import '../spell.dart';

/// 0 cost spell. Deal 1 damage to a creature.
class CowBeamCard extends CardObject with Spell implements IOnEnterField {
  /// [id] must be unique. [owner] cannot be changed.
  const CowBeamCard({
    required int id,
    required Player owner,
    required Player controller,
    required Location location,
  }) : super(id: id, owner: owner, controller: controller, location: location);

  // OnEnterField
  @override
  List<Effect> get onEnterFieldEffects => [
        DamageEffect(
            controller: controller,
            damage: 1,
            target: CreatureTarget(controller: controller))
      ];

  @override
  CowBeamCard copyWith(
          {int? id, Player? owner, Player? controller, Location? location}) =>
      CowBeamCard(
          id: id ?? this.id,
          owner: owner ?? this.owner,
          controller: controller ?? this.controller,
          location: location ?? this.location);

  @override
  List<Object> get props => [id, owner, controller, location];
}
