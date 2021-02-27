import 'damage_effect.dart';
import 'draw_cards_effect.dart';
import 'effect.dart';

/// Container for functions creating cards from json.
Map<Type, Effect Function(List<dynamic>)> effectBuilders = {
  DamageEffect: DamageEffect.fromJson,
  DrawCardsEffect: DrawCardsEffect.fromJson,
};
