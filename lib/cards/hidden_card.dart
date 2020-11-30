import '../models/card_object.dart';
import '../models/enums/location.dart';
import '../models/enums/player.dart';

/// Representation of a hidden card in a game state. ID is -1. Game states
/// containing this should not be iterated.
class HiddenCard extends CardObject {
  /// Representation of a hidden card in a game state. ID is -1. Game states
  /// containing this should not be iterated.
  const HiddenCard({
    required Player owner,
    required Player controller,
    required Location location,
  }) : super(id: -1, owner: owner, controller: controller, location: location);

  @override
  bool get permanent => false;

  @override
  int get cardId => -1;

  @override
  int get setId => -1;

  @override
  CardObject copyWith(
      {int? id, Player? owner, Player? controller, Location? location}) {
    if (id != null && id != -1) {
      throw ArgumentError('Hidden card ID must be -1.');
    }
    return HiddenCard(
        owner: owner ?? this.owner,
        controller: controller ?? this.controller,
        location: location ?? this.location);
  }

  @override
  List<Object> get props => [id, owner, controller, location];
}
