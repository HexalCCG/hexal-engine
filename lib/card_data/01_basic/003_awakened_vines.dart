import '../../card/creature.dart';
import '../../card/card.dart';
import '../../model/card_identity.dart';
import '../../model/enums/element.dart';
import '../../model/enums/location.dart';
import '../../model/enums/player.dart';

/// 1/2 vanilla creature.
class AwakenedVines extends Card with Creature {
  @override
  CardIdentity get identity => const CardIdentity(1, 3);
  @override
  Element get element => Element.earth;

  @override
  int get baseAttack => 1;
  @override
  int get baseHealth => 2;

  @override
  final int damage;

  /// [id] must be unique. [owner] cannot be changed.
  const AwakenedVines({
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
  AwakenedVines copyWith({
    int? id,
    Player? owner,
    Player? controller,
    Location? location,
  }) =>
      AwakenedVines(
        id: id ?? this.id,
        owner: owner ?? this.owner,
        controller: controller ?? this.controller,
        location: location ?? this.location,
        damage: damage,
      );

  @override
  AwakenedVines copyWithCreature({
    int? damage,
  }) =>
      AwakenedVines(
        id: id,
        owner: owner,
        controller: controller,
        location: location,
        damage: damage ?? this.damage,
      );
}
