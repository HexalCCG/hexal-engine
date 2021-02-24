import 'package:equatable/equatable.dart';

/// Relevent changes that occurred this turn.
class History extends Equatable {
  /// Which cards entered the field this turn.
  final List<int> enteredFieldThisTurn;

  /// Which cards attacked this turn.
  final List<int> attackedThisTurn;

  /// Relevent changes that occurred this turn.
  const History(
      {required this.enteredFieldThisTurn, required this.attackedThisTurn});

  /// Create a Card from its JSON form.
  History.fromJson(List<dynamic> json)
      : enteredFieldThisTurn = json[0] as List<int>,
        attackedThisTurn = json[1] as List<int>;

  @override
  List<Object> get props => [enteredFieldThisTurn, attackedThisTurn];

  /// Encode this card as JSON.
  List<Object> toJson() => props;
}
