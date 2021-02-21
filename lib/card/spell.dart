import '../models/card.dart';

/// Card with no stats that provides an effect.
mixin Spell on Card {
  @override
  bool get permanent => false;
}
