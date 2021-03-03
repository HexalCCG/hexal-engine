import '../../card/creature.dart';
import '../../card/card.dart';
import '../../model/card_identity.dart';
import '../../model/enums/element.dart';
import '../../model/enums/location.dart';
import '../../model/enums/player.dart';
import '../../model/mana_amount.dart';

/// 3/3 creature.
class ProtectorOfTheForest extends Card with Creature {
  @override
  CardIdentity get identity => const CardIdentity(1, 19);
  @override
  Element get element => Element.earth;

  @override
  int get baseAttack => 3;
  @override
  int get baseHealth => 3;

  @override
  ManaAmount get manaCost => const ManaAmount(earth: 1, neutral: 1);

  @override
  final int damage;

  /// [id] must be unique. [owner] cannot be changed.
  const ProtectorOfTheForest({
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
  ProtectorOfTheForest copyWith({
    int? id,
    Player? owner,
    Player? controller,
    Location? location,
  }) =>
      ProtectorOfTheForest(
        id: id ?? this.id,
        owner: owner ?? this.owner,
        controller: controller ?? this.controller,
        location: location ?? this.location,
        damage: damage,
      );

  @override
  ProtectorOfTheForest copyWithCreature({
    int? damage,
  }) =>
      ProtectorOfTheForest(
        id: id,
        owner: owner,
        controller: controller,
        location: location,
        damage: damage ?? this.damage,
      );
}
