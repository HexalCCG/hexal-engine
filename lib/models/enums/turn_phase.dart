/// A phase of a turn.
class TurnPhase {
  final int _index;
  const TurnPhase._(this._index);

  /// Create a GameState from its JSON encoding.
  TurnPhase.fromJson(Map<String, dynamic> json) : _index = json['index'] as int;

  /// Encode this GameState as JSON.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'index': _index,
      };

  /// First phase of a turn where effects are activated.
  static const TurnPhase start = TurnPhase._(0);

  /// Phase where the active player draws a card.
  static const TurnPhase draw = TurnPhase._(1);

  /// First phase where active player can play main speed cards.
  static const TurnPhase main1 = TurnPhase._(2);

  /// Active player can make attacks.
  static const TurnPhase battle = TurnPhase._(3);

  /// Inactive player may counterattack if they were attacked.
  static const TurnPhase counter = TurnPhase._(4);

  /// Second phase where active player can play main speed cards.
  static const TurnPhase main2 = TurnPhase._(5);

  /// Final phase where effects can be activated.
  static const TurnPhase end = TurnPhase._(6);
}
