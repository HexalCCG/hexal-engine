import '../models/card.dart';

/// Permanent card with stats that can attack and block attacks.
mixin Hero on Card {
  @override
  bool get permanent => true;
}
