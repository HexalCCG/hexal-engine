import 'package:hexal_engine/objects/card_object.dart';
import 'package:meta/meta.dart';

import 'package:hexal_engine/cards/mi_creature.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/player.dart';

class CowBeamCard extends CardObject with MCreature implements ICreature {
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
  @override
  final int damage;

  @override
  int get baseAttack => 1;
  @override
  int get baseHealth => 1;

  const CowBeamCard(
      {@required this.id,
      @required this.owner,
      @required this.controller,
      @required this.location,
      @required this.enteredFieldThisTurn,
      @required this.damage});

  @override
  CowBeamCard copyWith(Map<String, dynamic> data) {
    return CowBeamCard(
      id: id,
      owner: owner,
      controller: data['controller'] ?? controller,
      location: data['location'] ?? location,
      enteredFieldThisTurn:
          data['enteredFieldThisTurn'] ?? enteredFieldThisTurn,
      damage: data['damage'] ?? damage,
    );
  }
}
