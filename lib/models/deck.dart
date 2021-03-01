import 'package:hexal_engine/models/card.dart';

import 'card_identity.dart';

class Deck {
  final List<CardIdentity> identities;

  const Deck({required this.identities});

  String toCode() {
    return identities
        .map((identity) =>
            identity.setId.toString() + '.' + identity.cardId.toString())
        .join(',');
  }

  static Deck fromCode(String code) {
    final identities = code.split(',').map((cardCode) {
      final list = cardCode.split('.');
      return CardIdentity(int.parse(list[0]), int.parse(list[1]));
    }).toList();
    return Deck(identities: identities);
  }

  //List<Card> toCards(int startingId) {}
}
