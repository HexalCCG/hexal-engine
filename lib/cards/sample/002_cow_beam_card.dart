import '../../effect/damage_effect.dart';
import '../../effect/effect.dart';
import '../../effect/target/creature_target.dart';
import '../../game_state/location.dart';
import '../../game_state/player.dart';
import '../i_on_enter_field.dart';
import '../spell.dart';

/// 0 cost spell. Deal 1 damage to a creature.
class CowBeamCard extends Spell implements IOnEnterField {
  /// [id] must be unique. [owner] cannot be changed.
  const CowBeamCard({
    required int id,
    required Player owner,
    required Player controller,
    required Location location,
  }) : super(id: id, owner: owner, controller: controller, location: location);

  @override
  List<Effect> get onEnterFieldEffects => [
        DamageEffect(
            controller: controller,
            damage: 1,
            target: CreatureTarget(controller: controller))
      ];

  @override
  CowBeamCard copyWithController(Player controller) => CowBeamCard(
      id: id, owner: owner, controller: controller, location: location);

  @override
  CowBeamCard copyWithLocation(Location location) => CowBeamCard(
      id: id, owner: owner, controller: controller, location: location);
}
