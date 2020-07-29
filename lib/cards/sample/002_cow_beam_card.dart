import 'package:hexal_engine/effect/damage_effect.dart';
import 'package:meta/meta.dart';

import '../../effect/effect.dart';
import '../../game_state/location.dart';
import '../../game_state/player.dart';
import '../../objects/card_object.dart';
import '../i_on_enter_field.dart';

class CowBeamCard extends CardObject implements IOnEnterField {
  @override
  final int id;
  @override
  final Player owner;
  @override
  final Player controller;
  @override
  final Location location;
  @override
  final bool enteredFieldThisTurn;

  const CowBeamCard({
    @required this.id,
    @required this.owner,
    @required this.controller,
    @required this.location,
    @required this.enteredFieldThisTurn,
  });

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
  List<Effect> get onEnterFieldEffects =>
      [DamageCreatureEffect(damage: 1, target: null)];
}
