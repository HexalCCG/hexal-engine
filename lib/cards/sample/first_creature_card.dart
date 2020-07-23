import 'package:meta/meta.dart';

import 'package:hexal_engine/cards/creature_card.dart';
import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/player.dart';

class FirstCreatureCard extends CreatureCard {
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

  const FirstCreatureCard(
      {@required this.owner,
      @required this.controller,
      @required this.location,
      @required this.enteredFieldThisTurn,
      @required this.damage});

  @override
  FirstCreatureCard copyWith(Map<String, dynamic> data) {
    return FirstCreatureCard(
      owner: data['owner'] ?? owner,
      controller: data['controller'] ?? controller,
      location: data['location'] ?? location,
      enteredFieldThisTurn:
          data['enteredFieldThisTurn'] ?? enteredFieldThisTurn,
      damage: data['damage'] ?? damage,
    );
  }
}