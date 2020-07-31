import 'package:hexal_engine/effect/damage_effect.dart';
import 'package:hexal_engine/effect/target/creature_target.dart';
import 'package:meta/meta.dart';

import '../../effect/effect.dart';
import '../../game_state/location.dart';
import '../../game_state/player.dart';
import '../../objects/card_object.dart';
import '../i_on_enter_field.dart';

class CowBeamCard extends CardObject implements IOnEnterField {
  const CowBeamCard({
    @required int id,
    @required Player owner,
    @required Player controller,
    @required Location location,
    bool enteredFieldThisTurn = false,
  }) : super(
            id: id,
            owner: owner,
            controller: controller,
            location: location,
            enteredFieldThisTurn: enteredFieldThisTurn);

  @override
  CowBeamCard copyWith(Map<String, dynamic> data) => CowBeamCard(
        id: id,
        owner: owner,
        controller: data['controller'] ?? controller,
        location: data['location'] ?? location,
        enteredFieldThisTurn:
            data['enteredFieldThisTurn'] ?? enteredFieldThisTurn,
      );

  @override
  List<Effect> get onEnterFieldEffects => [
        DamageEffect(
            controller: controller,
            damage: 1,
            target: CreatureTarget(controller: controller))
      ];
}
