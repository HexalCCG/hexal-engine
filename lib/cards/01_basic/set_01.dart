import '../../models/card.dart';
import '../../models/card_identity.dart';
import '000_hivequeen_ngaat.dart';
import '003_awakened_vines.dart';
import '004_carnivorous_fern.dart';
import '007_peach_sapling.dart';

/// 01 Basic Set
final Map<CardIdentity, Card Function(List<dynamic>)> set_01 = {
  const CardIdentity(1, 0): HivequeenNgaat.fromJson,
  const CardIdentity(1, 3): AwakenedVines.fromJson,
  const CardIdentity(1, 4): CarnivorousFern.fromJson,
  const CardIdentity(1, 7): PeachSapling.fromJson,
};
