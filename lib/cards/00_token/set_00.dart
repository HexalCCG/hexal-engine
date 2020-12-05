import '../../models/card_object.dart';
import '000_test_card.dart';
import '001_cow_creature_card.dart';
import '002_cow_beam_card.dart';

/// 00 Sample Cards
const Map<int, CardObject Function(List<dynamic>)> set_00 = {
  0: TestCard.fromJson,
  1: CowCreatureCard.fromJson,
  2: CowBeamCard.fromJson,
};
