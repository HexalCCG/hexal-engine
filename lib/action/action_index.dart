import '../model/game_state.dart';

import 'action.dart';
import 'activate_triggered_effect_action.dart';
import 'attack_action.dart';
import 'attack_player_action.dart';
import 'pass_action.dart';
import 'play_card_action.dart';
import 'provide_mana_action.dart';
import 'provide_target_action.dart';

export 'action.dart';
export 'activate_triggered_effect_action.dart';
export 'attack_action.dart';
export 'attack_player_action.dart';
export 'pass_action.dart';
export 'play_card_action.dart';
export 'provide_mana_action.dart';
export 'provide_target_action.dart';

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

/// Whether all actions can be auto passed.
bool canAutoPass(GameState state) =>
    ActivateTriggeredEffectAction.canAutoPass(state) &&
    AttackAction.canAutoPass(state) &&
    AttackPlayerAction.canAutoPass(state) &&
    PassAction.canAutoPass(state) &&
    PlayCardAction.canAutoPass(state) &&
    ProvideManaAction.canAutoPass(state) &&
    ProvideTargetAction.canAutoPass(state);
