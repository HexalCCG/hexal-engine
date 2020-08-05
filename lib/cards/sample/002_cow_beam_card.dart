import 'package:meta/meta.dart';

import '../../effect/damage_effect.dart';
import '../../effect/effect.dart';
import '../../effect/target/creature_target.dart';
import '../../game_state/location.dart';
import '../../game_state/player.dart';
import '../i_on_enter_field.dart';
import '../spell.dart';

class CowBeamCard extends Spell implements IOnEnterField {
  const CowBeamCard({
    @required int id,
    @required Player owner,
    @required Player controller,
    @required Location location,
  }) : super(id: id, owner: owner, controller: controller, location: location);

  @override
  CowBeamCard copyWith(Map<String, dynamic> data) => CowBeamCard(
        id: id,
        owner: owner,
        controller: data['controller'] ?? controller,
        location: data['location'] ?? location,
      );

  @override
  List<Effect> get onEnterFieldEffects => [
        DamageEffect(
            controller: controller,
            damage: 1,
            target: CreatureTarget(controller: controller))
      ];
}
