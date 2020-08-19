/// Locations in the game that cards can exist in.
enum Location {
  /// The deck.
  deck,

  /// A hand.
  hand,

  /// The mana pool.
  mana,

  /// The field.
  field,

  /// The exile area.
  exile,

  /// A temporary space holding cards after they are revealed but before they
  /// enter the field.
  limbo,
}
