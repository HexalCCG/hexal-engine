import '../game_state/location.dart';
import '../game_state/player.dart';
import 'game_object.dart';

abstract class CardObject extends GameObject {
  Player get owner;
  Player get controller;
  Location get location;
  bool get enteredFieldThisTurn;

  const CardObject();

  dynamic copyWith(Map<String, dynamic> data);

  @override
  List<Object> get props => [owner, controller, location, enteredFieldThisTurn];
}
