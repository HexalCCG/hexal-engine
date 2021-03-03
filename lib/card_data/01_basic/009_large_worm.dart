import '../../card/creature.dart';
import '../../card/card.dart';
import '../../model/card_identity.dart';
import '../../model/enums/element.dart';
import '../../model/enums/location.dart';
import '../../model/enums/player.dart';
import '../../model/mana_amount.dart';

/// 2/2 Earth creature.
class LargeWorm extends Card with Creature {
  @override
  CardIdentity get identity => const CardIdentity(1, 9);
  @override
  Element get element => Element.earth;

  @override
  int get baseAttack => 2;
  @override
  int get baseHealth => 2;

  @override
  ManaAmount get manaCost => const ManaAmount(neutral: 1);

  @override
  final int damage;

  /// [id] must be unique. [owner] cannot be changed.
  const LargeWorm({
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
  LargeWorm copyWith({
    int? id,
    Player? owner,
    Player? controller,
    Location? location,
  }) =>
      LargeWorm(
        id: id ?? this.id,
        owner: owner ?? this.owner,
        controller: controller ?? this.controller,
        location: location ?? this.location,
        damage: damage,
      );

  @override
  LargeWorm copyWithCreature({
    int? damage,
  }) =>
      LargeWorm(
        id: id,
        owner: owner,
        controller: controller,
        location: location,
        damage: damage ?? this.damage,
      );
}
