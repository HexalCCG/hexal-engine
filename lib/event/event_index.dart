import '../effect/effect_index.dart';
import 'attack_event.dart';
import 'attack_player_event.dart';
import 'cast_card_event.dart';
import 'channel_card_event.dart';
import 'damage_creature_event.dart';
import 'damage_player_event.dart';
import 'destroy_card_event.dart';
import 'draw_cards_event.dart';
import 'event.dart';
import 'on_card_enter_field_event.dart';
import 'play_card_event.dart';
import 'require_mana_event.dart';

export 'attack_event.dart';
export 'attack_player_event.dart';
export 'cast_card_event.dart';
export 'channel_card_event.dart';
export 'damage_creature_event.dart';
export 'damage_player_event.dart';
export 'destroy_card_event.dart';
export 'draw_cards_event.dart';
export 'event.dart';
export 'on_card_enter_field_event.dart';
export 'play_card_event.dart';
export 'require_mana_event.dart';

/// Container for functions creating cards from json.
Map<Type, Event Function(List<dynamic>)> eventBuilders = {
  AttackEvent: AttackEvent.fromJson,
  AttackPlayerEvent: AttackPlayerEvent.fromJson,
  CastCardEvent: CastCardEvent.fromJson,
  ChannelCardEvent: ChannelCardEvent.fromJson,
  DamageCreatureEvent: DamageCreatureEvent.fromJson,
  DamagePlayerEvent: DamagePlayerEvent.fromJson,
  DestroyCardEvent: DestroyCardEvent.fromJson,
  DrawCardsEvent: DrawCardsEvent.fromJson,
  OnCardEnterFieldEvent: OnCardEnterFieldEvent.fromJson,
  PlayCardEvent: PlayCardEvent.fromJson,
  RequireManaEvent: RequireManaEvent.fromJson,
  ...effectBuilders,
};
