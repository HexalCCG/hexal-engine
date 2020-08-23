import 'package:hexal_engine/models/card_object.dart';
import 'package:hexal_engine/models/game_object.dart';

import '../../effects/damage_effect.dart';
import '../../effects/effect.dart';
import '../../effects/target/creature_target.dart';
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
  CowBeamCard copyWith(Map<String, dynamic> changes) => CowBeamCard(
        id: changes['id'] as int? ?? id,
        owner: changes['owner'] as Player? ?? owner,
        controller: changes['controller'] as Player? ?? controller,
        location: changes['location'] as Location? ?? location,
      );

  @override
  List<Object> get props => [id, owner, controller, location];
}
