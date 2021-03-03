import 'card.dart';
import '../model/enums/element.dart';
import '../model/mana_amount.dart';

/// Provides defaults for a card with an element.
mixin CardElement<T extends Element> on Card {
  @override
  ManaAmount get providesMana => throw UnimplementedError();
}
