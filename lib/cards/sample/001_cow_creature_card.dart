import '../../game_state/location.dart';
import '../../game_state/player.dart';
import '../creature.dart';

/// 2/2 Vanilla Creature.
class CowCreatureCard extends Creature {
  /// [id] must be unique. [owner] cannot be changed.
  const CowCreatureCard({
    required int id,
    required Player owner,
    required Player controller,
    required Location location,
    required bool exhausted,
    required bool enteredFieldThisTurn,
    required int damage,
  }) : super(
            id: id,
            owner: owner,
            controller: controller,
            location: location,
            exhausted: exhausted,
            enteredFieldThisTurn: enteredFieldThisTurn,
            damage: damage);

  @override
  int get baseAttack => 2;
  @override
  int get baseHealth => 2;

  @override
  CowCreatureCard copyWithBase({Player? controller, Location? location}) =>
      CowCreatureCard(
          id: id,
          owner: owner,
          controller: controller ?? this.controller,
          location: location ?? this.location,
          exhausted: exhausted,
          enteredFieldThisTurn: enteredFieldThisTurn,
          damage: damage);
  @override
  Creature copyWithCreature(
          {int? damage, bool? enteredFieldThisTurn, bool? exhausted}) =>
      CowCreatureCard(
          id: id,
          owner: owner,
          controller: controller,
          location: location,
          exhausted: exhausted ?? this.exhausted,
          enteredFieldThisTurn:
              enteredFieldThisTurn ?? this.enteredFieldThisTurn,
          damage: damage ?? this.damage);
}
