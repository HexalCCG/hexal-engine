/// A phase of a turn.
enum TurnPhase {
  /// First phase of a turn where effects are activated.
  start,

  /// Phase where the active player draws a card.
  draw,

  /// First phase where active player can play main speed cards.
  main1,

  /// Active player can make attacks.
  battle,

  /// Inactive player may counterattack if they were attacked.
  counter,

  /// Second phase where active player can play main speed cards.
  main2,

  /// Final phase where effects can be activated.
  end,
}
