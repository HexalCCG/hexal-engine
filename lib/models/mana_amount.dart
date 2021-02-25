import 'package:equatable/equatable.dart';

import 'enums/element.dart';

/// Represents an amount of mana of multiple elements.
class ManaAmount extends Equatable {
  /// Neutral mana in this amount.
  final int neutral;

  /// Fire mana in this amount.
  final int fire;

  /// Earth mana in this amount.
  final int earth;

  /// Air mana in this amount.
  final int air;

  /// Water mana in this amount.
  final int water;

  /// Spirit mana in this amount.
  final int spirit;

  /// Wild mana in this amount.
  final int wild;

  /// Represents an amount of mana of multiple elements.
  const ManaAmount(
      {this.neutral = 0,
      this.fire = 0,
      this.earth = 0,
      this.air = 0,
      this.water = 0,
      this.spirit = 0,
      this.wild = 0});

  /// Mana amount with all elements at zero.
  const ManaAmount.zero()
      : neutral = 0,
        fire = 0,
        earth = 0,
        air = 0,
        water = 0,
        spirit = 0,
        wild = 0;

  /// Returns a new ManaAmount with elements from each object added.
  ManaAmount operator +(ManaAmount other) {
    return ManaAmount(
      neutral: neutral + other.neutral,
      fire: fire + other.fire,
      earth: earth + other.earth,
      air: air + other.air,
      water: water + other.water,
      spirit: spirit + other.spirit,
      wild: wild + other.wild,
    );
  }

  /// Get a view of this mana amount as a map.
  Map<Element, int> get asMap => {
        Element.neutral: neutral,
        Element.fire: fire,
        Element.earth: earth,
        Element.air: air,
        Element.water: water,
        Element.spirit: spirit,
        Element.wild: wild,
      };

  /// Returns true if [other] has enough of all elements to fill [this].
  bool isFilledBy(ManaAmount other) {
    final _cost = asMap;
    final _provided = other.asMap;

    // We check neutral at the end when specific colours have been taken.
    // Cost shouldn't include any Any but if it does it shouldn't be a problem.
    for (final entry
        in _cost.entries.where((element) => element.key != Element.neutral)) {
      final element = entry.key;
      var amount = entry.value;

      if (amount == 0) {
        // None of this element required.
        continue;
      } else {
        if ((_provided[element] ?? 0) >= amount) {
          // Enough of this specific element provided!
          if (_provided[element] != null) {
            _provided.update(element, (value) => value - amount);
          }
          continue;
        } else {
          // Not enough of this element.
          amount -= (_provided[element] ?? 0);
          if (_provided[element] != null) {
            _provided.update(element, (value) => 0);
          }
          // Check remaining cost against wildcard mana.
          if ((_provided[Element.wild] ?? 0) >= amount) {
            if (_provided[Element.wild] != null) {
              _provided.update(Element.wild, (value) => value - amount);
            }
            continue;
          } else {
            // Not enough mana of this colour.
            return false;
          }
        }
      }
    }

    // Check neutral mana.
    if ((_cost[Element.neutral] ?? 0) >
        _provided.values.reduce((i, j) => i + j)) {
      // Not enough mana left to cover neutral cost.
      return false;
    }

    return true;
  }

  @override
  List<Object?> get props => [neutral, fire, earth, air, water, spirit, wild];
}
