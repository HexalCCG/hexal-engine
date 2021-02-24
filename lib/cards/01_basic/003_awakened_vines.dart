import '../../card/creature.dart';
import '../../models/card.dart';
import '../../models/card_identity.dart';
import '../../models/enums/location.dart';
import '../../models/enums/player.dart';

/// 1/2 vanilla creature.
class AwakenedVines extends Card with Creature {
  @override
  CardIdentity get identity => const CardIdentity(1, 3);

  @override
  int get baseAttack => 1;
  @override
  int get baseHealth => 2;

  /// [id] must be unique. [owner] cannot be changed.
  const AwakenedVines({
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

  /// Create from json.
  static AwakenedVines fromJson(List<dynamic> json) => AwakenedVines(
        id: json[0] as int,
        owner: Player.fromIndex(json[1] as int),
        controller: Player.fromIndex(json[2] as int),
        location: Location.fromIndex(json[3] as int),
        damage: json[4] as int,
      );

  @override
  List<Object> get props => [id, owner, controller, location, damage];
}
