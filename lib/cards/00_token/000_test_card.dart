import '../../card/spell.dart';
import '../../models/card.dart';
import '../../models/card_identity.dart';
import '../../models/enums/location.dart';
import '../../models/enums/player.dart';

/// Test spell with no effects or cost.
class TestCard extends Card with Spell {
  @override
  CardIdentity get identity => const CardIdentity(0, 0);

  /// [id] must be unique. [owner] cannot be changed.
  const TestCard({
    required int id,
    required Player owner,
    required Player controller,
    required Location location,
  }) : super(id: id, owner: owner, controller: controller, location: location);

  @override
  TestCard copyWith(
          {int? id, Player? owner, Player? controller, Location? location}) =>
      TestCard(
          id: id ?? this.id,
          owner: owner ?? this.owner,
          controller: controller ?? this.controller,
          location: location ?? this.location);

  /// Create from json.
  static TestCard fromJson(List<dynamic> json) => TestCard(
        id: json[0] as int,
        owner: Player.fromIndex(json[1] as int),
        controller: Player.fromIndex(json[2] as int),
        location: Location.fromIndex(json[3] as int),
      );

  @override
  List<Object> get props => [id, owner, controller, location];
}
