import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/player.dart';
import 'package:hexal_engine/objects/card_object.dart';

class CreatureCard extends CardObject {
  int get baseHealth => 0;
  int get baseAttack => 0;

  int get health => baseHealth - damage;
  int get attack => baseAttack;

  final int damage;

  const CreatureCard(
      {Player owner,
      Player controller,
      Location location,
      bool enteredFieldThisTurn,
      this.damage})
      : super(
            owner: owner,
            controller: controller,
            location: location,
            enteredFieldThisTurn: enteredFieldThisTurn);

  @override
  CreatureCard copyWith({
    Player owner,
    Player controller,
    Location location,
    bool enteredFieldThisTurn,
    int damage,
  }) {
    return CreatureCard(
      owner: owner ?? this.owner,
      controller: controller ?? this.controller,
      location: location ?? this.location,
      enteredFieldThisTurn: enteredFieldThisTurn ?? this.enteredFieldThisTurn,
      damage: damage ?? this.damage,
    );
  }

  @override
  List<Object> get props =>
      [owner, controller, location, enteredFieldThisTurn, damage];
}
