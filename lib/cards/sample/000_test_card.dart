import 'package:meta/meta.dart';

import '../../game_state/location.dart';
import '../../game_state/player.dart';
import '../../objects/card_object.dart';

class TestCard extends CardObject {
  const TestCard({
    @required int id,
    @required Player owner,
    @required Player controller,
    @required Location location,
    bool enteredFieldThisTurn,
  }) : super(
            id: id,
            owner: owner,
            controller: controller,
            location: location,
            enteredFieldThisTurn: enteredFieldThisTurn);

  @override
  TestCard copyWith(Map<String, dynamic> data) => TestCard(
        id: id,
        owner: owner,
        controller: data['controller'] ?? controller,
        location: data['location'] ?? location,
        enteredFieldThisTurn:
            data['enteredFieldThisTurn'] ?? enteredFieldThisTurn,
      );
}
