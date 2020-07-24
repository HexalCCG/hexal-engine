import 'package:hexal_engine/objects/card_object.dart';
import 'package:meta/meta.dart';

import 'package:hexal_engine/game_state/location.dart';
import 'package:hexal_engine/game_state/player.dart';

class TestCard extends CardObject {
  @override
  final Player owner;
  @override
  final Player controller;
  @override
  final Location location;
  @override
  final bool enteredFieldThisTurn;

  const TestCard({
    @required this.owner,
    @required this.controller,
    @required this.location,
    @required this.enteredFieldThisTurn,
  });

  @override
  TestCard copyWith(Map<String, dynamic> data) {
    return TestCard(
      owner: data['owner'] ?? owner,
      controller: data['controller'] ?? controller,
      location: data['location'] ?? location,
      enteredFieldThisTurn:
          data['enteredFieldThisTurn'] ?? enteredFieldThisTurn,
    );
  }
}
