import '../effects/trigger/triggered_effect.dart';
import 'card.dart';

/// Has an onTrigger effect.
mixin OnTrigger on Card {
  /// List of effects triggered when this enters the field.
  List<TriggeredEffect> get onTriggerEffects;
}
