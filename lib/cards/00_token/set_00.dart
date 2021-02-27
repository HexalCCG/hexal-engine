import 'package:hexal_engine/cards/00_token/003_expensive_cow.dart';

import '../../models/card.dart';
import '../../models/card_identity.dart';
import '000_test_card.dart';
import '001_cow_creature_card.dart';
import '002_cow_beam_card.dart';

/// 00 Sample Cards
final Map<CardIdentity, Card Function(List<dynamic>)> set_00 = {
  const CardIdentity(0, 0): TestCard.fromJson,
  const CardIdentity(0, 1): CowCreatureCard.fromJson,
  const CardIdentity(0, 2): CowBeamCard.fromJson,
  const CardIdentity(0, 3): ExpensiveCowCard.fromJson,
};
