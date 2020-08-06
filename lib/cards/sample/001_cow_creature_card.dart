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
    bool exhausted = false,
    bool enteredFieldThisTurn = false,
    int damage = 0,
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
  CowCreatureCard copyWithController(Player controller) => CowCreatureCard(
      id: id,
      owner: owner,
      controller: controller,
      location: location,
      exhausted: exhausted,
      enteredFieldThisTurn: enteredFieldThisTurn,
      damage: damage);
  @override
  CowCreatureCard copyWithLocation(Location location) => CowCreatureCard(
      id: id,
      owner: owner,
      controller: controller,
      location: location,
      exhausted: exhausted,
      enteredFieldThisTurn: enteredFieldThisTurn,
      damage: damage);
  @override
  Creature copyWithDamage(int damage) => CowCreatureCard(
      id: id,
      owner: owner,
      controller: controller,
      location: location,
      exhausted: exhausted,
      enteredFieldThisTurn: enteredFieldThisTurn,
      damage: damage);
  @override
  Creature copyWithEnteredFieldThisTurn(bool enteredFieldThisTurn) =>
      CowCreatureCard(
          id: id,
          owner: owner,
          controller: controller,
          location: location,
          exhausted: exhausted,
          enteredFieldThisTurn: enteredFieldThisTurn,
          damage: damage);
  @override
  Creature copyWithExhausted(int damage) => CowCreatureCard(
      id: id,
      owner: owner,
      controller: controller,
      location: location,
      exhausted: exhausted,
      enteredFieldThisTurn: enteredFieldThisTurn,
      damage: damage);
}
