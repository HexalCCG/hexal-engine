import '../../card/creature.dart';
import '../../card/ready.dart';
import '../../card/card.dart';
import '../../models/card_identity.dart';
import '../../models/enums/element.dart';
import '../../models/enums/location.dart';
import '../../models/enums/player.dart';

/// 1/2 vanilla creature.
class CarnivorousFern extends Card with Creature, Ready {
  @override
  CardIdentity get identity => const CardIdentity(1, 4);
  @override
  Element get element => Element.earth;

  @override
  int get baseAttack => 2;
  @override
  int get baseHealth => 1;

  /// [id] must be unique. [owner] cannot be changed.
  const CarnivorousFern({
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
  CarnivorousFern copyWith({
    int? id,
    Player? owner,
    Player? controller,
    Location? location,
  }) =>
      CarnivorousFern(
        id: id ?? this.id,
        owner: owner ?? this.owner,
        controller: controller ?? this.controller,
        location: location ?? this.location,
        damage: damage,
      );

  @override
  CarnivorousFern copyWithCreature({
    int? damage,
  }) =>
      CarnivorousFern(
        id: id,
        owner: owner,
        controller: controller,
        location: location,
        damage: damage ?? this.damage,
      );
}
