import 'package:hexal_engine/models/card_identity.dart';
import 'package:hexal_engine/models/deck.dart';
import 'package:test/test.dart';

void main() {
  const deck = Deck(identities: [
    CardIdentity(1, 7),
    CardIdentity(1, 7),
    CardIdentity(1, 7),
    CardIdentity(1, 9),
    CardIdentity(1, 15),
    CardIdentity(1, 15),
    CardIdentity(1, 16),
  ]);

  test('Deck code conversion works.', () {
    print(deck.toCode());
  });
}
