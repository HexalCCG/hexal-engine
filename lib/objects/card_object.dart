import 'package:meta/meta.dart';

import '../game_state/location.dart';
import '../game_state/player.dart';
import 'game_object.dart';

class CardObject extends GameObject {
  final Player owner;
  final Player controller;
  final Location location;
  final bool enteredBattlefieldThisTurn;

  const CardObject({
    @required this.owner,
    @required this.controller,
    @required this.location,
    @required this.enteredBattlefieldThisTurn,
  });

  CardObject copyWith({
    Player owner,
    Player controller,
    Location location,
    bool enteredBattlefieldThisTurn,
  }) {
    return CardObject(
      owner: owner ?? this.owner,
      controller: controller ?? this.controller,
      location: location ?? this.location,
      enteredBattlefieldThisTurn:
          enteredBattlefieldThisTurn ?? this.enteredBattlefieldThisTurn,
    );
  }

  @override
  List<Object> get props =>
      [owner, controller, location, enteredBattlefieldThisTurn];
}
