import '../../game_state/location.dart';
import '../../game_state/player.dart';
import '../spell.dart';

/// Test spell with no effects or cost.
class TestCard extends Spell {
  /// Test spell with no effects or cost.
  const TestCard({
    required int id,
    required Player owner,
    required Player controller,
    required Location location,
  }) : super(id: id, owner: owner, controller: controller, location: location);

  @override
  TestCard copyWithController(Player controller) => TestCard(
      id: id, owner: owner, controller: controller, location: location);
  @override
  TestCard copyWithLocation(Location location) => TestCard(
      id: id, owner: owner, controller: controller, location: location);
}
