import '../../card/creature.dart';
import '../../models/card.dart';
import '../../models/card_identity.dart';
import '../../models/enums/element.dart';
import '../../models/enums/location.dart';
import '../../models/enums/player.dart';
import '../../models/mana_amount.dart';

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
    required int id,
    required Player owner,
    required Player controller,
    required Location location,
    required this.damage,
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

  /// Create from json.
  static ExpensiveCowCard fromJson(List<dynamic> json) => ExpensiveCowCard(
        id: json[0] as int,
        owner: Player.fromIndex(json[1] as int),
        controller: Player.fromIndex(json[2] as int),
        location: Location.fromIndex(json[3] as int),
        damage: json[4] as int,
      );

  @override
  List<Object> get props => [id, owner, controller, location, damage];
}
