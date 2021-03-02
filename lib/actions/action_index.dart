import 'package:hexal_engine/actions/provide_mana_action.dart';

import 'action.dart';
import 'activate_triggered_effect_action.dart';
import 'attack_action.dart';
import 'attack_player_action.dart';
import 'pass_action.dart';
import 'play_card_action.dart';
import 'provide_target_action.dart';

/// Container for functions creating cards from json.
Map<Type, Action Function(List<dynamic>)> actionBuilders = {
  ActivateTriggeredEffectAction: ActivateTriggeredEffectAction.fromJson,
  AttackAction: AttackAction.fromJson,
  AttackPlayerAction: AttackPlayerAction.fromJson,
  PassAction: PassAction.fromJson,
  PlayCardAction: PlayCardAction.fromJson,
  ProvideManaAction: ProvideManaAction.fromJson,
  ProvideTargetAction: ProvideTargetAction.fromJson,
};
