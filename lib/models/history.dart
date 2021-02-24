import 'package:equatable/equatable.dart';

/// Relevent changes that occurred this turn.
class History extends Equatable {
  /// Which cards entered the field this turn.
  final Set<int> enteredFieldThisTurn;

  /// Which cards attacked this turn.
  final Set<int> attackedThisTurn;

  /// Relevent changes that occurred this turn.
  const History(
      {required this.enteredFieldThisTurn, required this.attackedThisTurn});

  /// Empty history.
  const History.empty()
      : enteredFieldThisTurn = const {},
        attackedThisTurn = const {};

  /// Create a copy of this with fields changed.
  History copyWith(
          {Set<int>? enteredFieldThisTurn, Set<int>? attackedThisTurn}) =>
      History(
        attackedThisTurn: attackedThisTurn ?? this.attackedThisTurn,
        enteredFieldThisTurn: enteredFieldThisTurn ?? this.enteredFieldThisTurn,
      );

  /// Copy this history with an id added to entered field this turn.
  History addEnteredFieldThisTurn(int id) =>
      copyWith(enteredFieldThisTurn: enteredFieldThisTurn.union({id}));

  /// Copy this history with an id added to attacked this turn.
  History addAttackedThisTurn(int id) =>
      copyWith(attackedThisTurn: attackedThisTurn.union({id}));

  /// Create a Card from its JSON form.
  History.fromJson(List<dynamic> json)
      : enteredFieldThisTurn = (json[0] as List<dynamic>)
            .map((dynamic i) => int.parse(i.toString()))
            .toSet(),
        attackedThisTurn = (json[1] as List<dynamic>)
            .map((dynamic i) => int.parse(i.toString()))
            .toSet();

  @override
  List<Object> get props => [enteredFieldThisTurn, attackedThisTurn];

  /// Encode this card as JSON.
  List<dynamic> toJson() => <dynamic>[
        // Must convert to list first as JSON does not support sets.
        enteredFieldThisTurn.toList(),
        attackedThisTurn.toList(),
      ];
}
