import 'package:equatable/equatable.dart';

/// Identifies a type of card by set and number.
class CardIdentity extends Equatable {
  /// Set this card belongs to.
  final int setId;

  /// Card within the set.
  final int cardId;

  /// Identifies a type of card by set and number.
  const CardIdentity(this.setId, this.cardId);

  /// Create a card identity from list of information.
  CardIdentity.fromJson(List<dynamic> json)
      : setId = int.parse(json[0].toString()),
        cardId = int.parse(json[1].toString());

  /// Convert to json.
  List<int> toJson() => [setId, cardId];

  @override
  List<Object?> get props => [setId, cardId];
}
