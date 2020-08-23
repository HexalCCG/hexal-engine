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
  TestCard copyWith(Map<String, dynamic> changes) => TestCard(
        id: changes['id'] as int? ?? id,
        owner: changes['owner'] as Player? ?? owner,
        controller: changes['controller'] as Player? ?? controller,
        location: changes['location'] as Location? ?? location,
      );

  @override
  List<Object> get props => [id, owner, controller, location];
}
