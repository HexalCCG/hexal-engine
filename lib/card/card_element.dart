import '../models/card.dart';
import '../models/enums/element.dart';
import '../models/mana_amount.dart';

/// Provides defaults for a card with an element.
mixin CardElement<T extends Element> on Card {
  @override
  ManaAmount get providesMana => throw UnimplementedError();
}
