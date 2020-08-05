import 'package:meta/meta.dart';

import '../../game_state/location.dart';
import '../../game_state/player.dart';
import '../spell.dart';

class TestCard extends Spell {
  const TestCard({
    @required int id,
    @required Player owner,
    @required Player controller,
    @required Location location,
  }) : super(
          id: id,
          owner: owner,
          controller: controller,
          location: location,
        );

  @override
  TestCard copyWith(Map<String, dynamic> data) => TestCard(
        id: id,
        owner: owner,
        controller: data['controller'] ?? controller,
        location: data['location'] ?? location,
      );
}
