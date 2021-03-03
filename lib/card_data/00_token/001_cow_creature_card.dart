import '../../card/creature.dart';
import '../../card/card.dart';
import '../../models/card_identity.dart';
import '../../models/enums/element.dart';
import '../../models/enums/location.dart';
import '../../models/enums/player.dart';

/// 2/2 Vanilla Creature.
class CowCreatureCard extends Card with Creature {
  @override
  CardIdentity get identity => const CardIdentity(0, 1);

  @override
  Element get element => Element.earth;

  @override
  int get baseAttack => 2;
  @override
  int get baseHealth => 2;

  /// [id] must be unique. [owner] cannot be changed.
  const CowCreatureCard({
    int id = 0,
    Player owner = Player.one,
    Player controller = Player.one,
    Location location = Location.deck,
    this.damage = 0,
  }) : super(
          id: id,
          owner: owner,
          controller: controller,
          location: location,
        );

  @override
  final int damage;

  @override
  CowCreatureCard copyWith({
    int? id,
    Player? owner,
    Player? controller,
    Location? location,
  }) =>
      CowCreatureCard(
        id: id ?? this.id,
        owner: owner ?? this.owner,
        controller: controller ?? this.controller,
        location: location ?? this.location,
        damage: damage,
      );

  @override
  CowCreatureCard copyWithCreature({
    bool? exhausted,
    bool? enteredFieldThisTurn,
    int? damage,
  }) =>
      CowCreatureCard(
        id: id,
        owner: owner,
        controller: controller,
        location: location,
        damage: damage ?? this.damage,
      );
}
