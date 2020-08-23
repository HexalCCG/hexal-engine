import '../../models/card_object.dart';
import '../../models/location.dart';
import '../../models/player.dart';
import '../spell.dart';

/// Test spell with no effects or cost.
class TestCard extends CardObject with Spell {
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

  @override
  List<Object> get props => [id, owner, controller, location];
}
