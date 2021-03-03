import 'package:equatable/equatable.dart';

import 'history_triggered_effect.dart';

/// Relevent changes that occurred this turn.
class History extends Equatable {
  /// Which cards entered the field this turn.
  final Set<int> enteredFieldThisTurn;

  /// Which cards attacked this turn.
  final Set<int> attackedThisTurn;

  /// Effects triggered this turn.
  final Set<HistoryTriggeredEffect> triggeredEffects;

  /// Relevent changes that occurred this turn.
  const History({
    required this.enteredFieldThisTurn,
    required this.attackedThisTurn,
    required this.triggeredEffects,
  });

  /// Empty history.
  const History.empty()
      : enteredFieldThisTurn = const {},
        attackedThisTurn = const {},
        triggeredEffects = const {};

  /// Create a copy of this with fields changed.
  History copyWith({
    Set<int>? enteredFieldThisTurn,
    Set<int>? attackedThisTurn,
    Set<HistoryTriggeredEffect>? triggeredEffects,
  }) =>
      History(
        attackedThisTurn: attackedThisTurn ?? this.attackedThisTurn,
        enteredFieldThisTurn: enteredFieldThisTurn ?? this.enteredFieldThisTurn,
        triggeredEffects: triggeredEffects ?? this.triggeredEffects,
      );

  /// Copy this history with an id added to entered field this turn.
  History addEnteredFieldThisTurn(int id) =>
      copyWith(enteredFieldThisTurn: enteredFieldThisTurn.union({id}));

  /// Copy this history with an id added to attacked this turn.
  History addAttackedThisTurn(int id) =>
      copyWith(attackedThisTurn: attackedThisTurn.union({id}));

  /// Copy this with a triggered effect added.
  History addTriggeredEffect(HistoryTriggeredEffect triggeredEffect) =>
      copyWith(triggeredEffects: triggeredEffects.union({triggeredEffect}));

  /// Create a Card from its JSON form.
  History.fromJson(List<dynamic> json)
      : enteredFieldThisTurn = (json[0] as List<dynamic>).cast<int>().toSet(),
        attackedThisTurn = (json[1] as List<dynamic>).cast<int>().toSet(),
        triggeredEffects = (json[2] as List<dynamic>)
            .cast<List<int>>()
            .map(HistoryTriggeredEffect.fromJson)
            .toSet();

  @override
  List<Object> get props => [enteredFieldThisTurn, attackedThisTurn];

  /// Encode this card as JSON.
  List<dynamic> toJson() => <dynamic>[
        // Must convert to list first as JSON does not support sets.
        enteredFieldThisTurn.toList(),
        attackedThisTurn.toList(),
        triggeredEffects.toList(),
      ];
}
