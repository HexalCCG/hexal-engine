import 'package:equatable/equatable.dart';

/// Identifies a type of card by set and number.
class CardIdentity extends Equatable {
  /// Set this card belongs to.
  final int setId;

  /// Card within the set.
  final int cardId;

  /// Identifies a type of card by set and number.
  const CardIdentity(this.setId, this.cardId);

  @override
  List<Object?> get props => [setId, cardId];
}
