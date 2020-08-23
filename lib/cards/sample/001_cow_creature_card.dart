import '../../models/card_object.dart';
import '../../models/location.dart';
import '../../models/player.dart';
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
  CowCreatureCard copyWith(Map<String, dynamic> changes) => CowCreatureCard(
        id: changes['id'] as int? ?? id,
        owner: changes['owner'] as Player? ?? owner,
        controller: changes['controller'] as Player? ?? controller,
        location: changes['location'] as Location? ?? location,
        exhausted: changes['exhausted'] as bool? ?? exhausted,
        enteredFieldThisTurn:
            changes['enteredFieldThisTurn'] as bool? ?? enteredFieldThisTurn,
        damage: changes['damage'] as int? ?? damage,
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
