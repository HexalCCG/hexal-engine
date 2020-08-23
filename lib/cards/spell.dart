import '../models/card_object.dart';

/// Card with no stats that provides an effect.
mixin Spell on CardObject {
  @override
  bool get permanent => false;
}
