import 'package:hexal_engine/objects/card_object.dart';

abstract class CreatureCard extends CardObject {
  int get baseHealth;
  int get baseAttack;

  int get health => baseHealth - damage;
  int get attack => baseAttack;

  int get damage;

  const CreatureCard();

  @override
  List<Object> get props =>
      [owner, controller, location, enteredFieldThisTurn, damage];
}
