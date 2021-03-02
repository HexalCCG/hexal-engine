import '../../card/card.dart';
import '../../models/card_identity.dart';
import '000_test_card.dart';
import '001_cow_creature_card.dart';
import '002_cow_beam_card.dart';
import '003_expensive_cow.dart';

/// 00 Sample Cards
final Map<CardIdentity, Card> set_00 = {
  const CardIdentity(0, 0): const TestCard(),
  const CardIdentity(0, 1): const CowCreatureCard(),
  const CardIdentity(0, 2): const CowBeamCard(),
  const CardIdentity(0, 3): const ExpensiveCowCard(),
};
