import '../../card/creature.dart';
import '../../models/card.dart';
import '../../models/card_identity.dart';
import '../../models/enums/location.dart';
import '../../models/enums/player.dart';

/// 2/2 Vanilla Creature.
class CowCreatureCard extends Card with Creature {
  @override
  CardIdentity get identity => const CardIdentity(0, 1);

  @override
  int get baseAttack => 2;
  @override
  int get baseHealth => 2;

  /// [id] must be unique. [owner] cannot be changed.
  const CowCreatureCard({
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

  /// Create from json.
  static CowCreatureCard fromJson(List<dynamic> json) => CowCreatureCard(
        id: json[0] as int,
        owner: Player.fromIndex(json[1] as int),
        controller: Player.fromIndex(json[2] as int),
        location: Location.fromIndex(json[3] as int),
        damage: json[4] as int,
      );

  @override
  List<Object> get props => [id, owner, controller, location, damage];
}
