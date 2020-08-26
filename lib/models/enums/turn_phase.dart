/// A phase of a turn.
class TurnPhase {
  /// Enum index.
  final int index;
  const TurnPhase._(this.index);

  /// Create from its JSON encoding.
  factory TurnPhase.fromIndex(int _index) => _all[_index];

  /// Encode as json.
  int toJson() => index;

  static const List<TurnPhase> _all = [
    start,
    draw,
    main1,
    battle,
    counter,
    main2,
    end,
  ];

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
