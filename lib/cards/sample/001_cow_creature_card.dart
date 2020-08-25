import '../../models/card_object.dart';
import '../../models/enums/location.dart';
import '../../models/enums/player.dart';
import '../creature.dart';

/// 2/2 Vanilla Creature.
class CowCreatureCard extends CardObject with Creature {
  final bool exhausted;
  final bool enteredFieldThisTurn;
  final int damage;

  /// [id] must be unique. [owner] cannot be changed.
  const CowCreatureCard({
    required int id,
    required Player owner,
    required Player controller,
    required Location location,
    required this.exhausted,
    required this.enteredFieldThisTurn,
    required this.damage,
  }) : super(
          id: id,
          owner: owner,
          controller: controller,
          location: location,
        );

  @override
  int get baseAttack => 2;
  @override
  int get baseHealth => 2;

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
        exhausted: exhausted,
        enteredFieldThisTurn: enteredFieldThisTurn,
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
        exhausted: exhausted ?? this.exhausted,
        enteredFieldThisTurn: enteredFieldThisTurn ?? this.enteredFieldThisTurn,
        damage: damage ?? this.damage,
      );

  @override
  List<Object> get props => [
        id,
        owner,
        controller,
        location,
        exhausted,
        enteredFieldThisTurn,
        damage
      ];
}
