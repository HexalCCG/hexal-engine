import '../../card/creature.dart';
import '../../models/card.dart';
import '../../models/card_identity.dart';
import '../../models/enums/element.dart';
import '../../models/enums/location.dart';
import '../../models/enums/player.dart';
import '../../models/mana_amount.dart';

/// 3/3 creature.
class ArmouredCrocodile extends Card with Creature {
  @override
  CardIdentity get identity => const CardIdentity(1, 16);
  @override
  Element get element => Element.earth;

  @override
  int get baseAttack => 3;
  @override
  int get baseHealth => 3;

  @override
  ManaAmount get manaCost => const ManaAmount(neutral: 2);

  @override
  final int damage;

  /// [id] must be unique. [owner] cannot be changed.
  const ArmouredCrocodile({
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
  ArmouredCrocodile copyWith({
    int? id,
    Player? owner,
    Player? controller,
    Location? location,
  }) =>
      ArmouredCrocodile(
        id: id ?? this.id,
        owner: owner ?? this.owner,
        controller: controller ?? this.controller,
        location: location ?? this.location,
        damage: damage,
      );

  @override
  ArmouredCrocodile copyWithCreature({
    int? damage,
  }) =>
      ArmouredCrocodile(
        id: id,
        owner: owner,
        controller: controller,
        location: location,
        damage: damage ?? this.damage,
      );
}
