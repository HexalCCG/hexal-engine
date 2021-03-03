import '../../card/creature.dart';
import '../../card/card.dart';
import '../../model/card_identity.dart';
import '../../model/enums/element.dart';
import '../../model/enums/location.dart';
import '../../model/enums/player.dart';
import '../../model/mana_amount.dart';

/// 3/3 creature that costs 1 mana.
class ExpensiveCowCard extends Card with Creature {
  @override
  CardIdentity get identity => const CardIdentity(0, 3);

  @override
  Element get element => Element.earth;

  @override
  ManaAmount get manaCost => const ManaAmount(neutral: 1);

  @override
  int get baseAttack => 3;
  @override
  int get baseHealth => 3;

  /// [id] must be unique. [owner] cannot be changed.
  const ExpensiveCowCard({
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
  ExpensiveCowCard copyWith({
    int? id,
    Player? owner,
    Player? controller,
    Location? location,
  }) =>
      ExpensiveCowCard(
        id: id ?? this.id,
        owner: owner ?? this.owner,
        controller: controller ?? this.controller,
        location: location ?? this.location,
        damage: damage,
      );

  @override
  ExpensiveCowCard copyWithCreature({
    bool? exhausted,
    bool? enteredFieldThisTurn,
    int? damage,
  }) =>
      ExpensiveCowCard(
        id: id,
        owner: owner,
        controller: controller,
        location: location,
        damage: damage ?? this.damage,
      );
}
