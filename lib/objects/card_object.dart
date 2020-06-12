import 'package:meta/meta.dart';

import '../game_state/location.dart';
import 'game_object.dart';
import 'player_object.dart';

@immutable
class CardObject extends GameObject {
  final PlayerObject owner;
  final PlayerObject controller;
  final Location location;
  final bool enteredBattlefieldThisTurn;

  const CardObject({
    @required this.owner,
    @required this.controller,
    @required this.location,
    @required this.enteredBattlefieldThisTurn,
  });

  CardObject copyWith({
    PlayerObject owner,
    PlayerObject controller,
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
