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

  /// Empty history.
  const History.empty()
      : enteredFieldThisTurn = const [],
        attackedThisTurn = const [];

  /// Create a Card from its JSON form.
  History.fromJson(List<dynamic> json)
      : enteredFieldThisTurn = (json[0] as List<dynamic>)
            .map((dynamic i) => int.parse(i.toString()))
            .toList(),
        attackedThisTurn = (json[1] as List<dynamic>)
            .map((dynamic i) => int.parse(i.toString()))
            .toList();

  @override
  List<Object> get props => [enteredFieldThisTurn, attackedThisTurn];

  /// Encode this card as JSON.
  List<Object> toJson() => props;
}
