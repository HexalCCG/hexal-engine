import '../effects/effect_index.dart';
import 'attack_event.dart';
import 'attack_player_event.dart';
import 'damage_creature_event.dart';
import 'damage_player_event.dart';
import 'destroy_card_event.dart';
import 'draw_card_event.dart';
import 'event.dart';
import 'on_card_enter_field_event.dart';
import 'play_card_event.dart';

/// Container for functions creating cards from json.
Map<Type, Event Function(List<dynamic>)> eventBuilders = {
  AttackEvent: AttackEvent.fromJson,
  AttackPlayerEvent: AttackPlayerEvent.fromJson,
  DamageCreatureEvent: DamageCreatureEvent.fromJson,
  DamagePlayerEvent: DamagePlayerEvent.fromJson,
  DestroyCardEvent: DestroyCardEvent.fromJson,
  DrawCardEvent: DrawCardEvent.fromJson,
  OnCardEnterFieldEvent: OnCardEnterFieldEvent.fromJson,
  PlayCardEvent: PlayCardEvent.fromJson,
  ...effectBuilders,
};
