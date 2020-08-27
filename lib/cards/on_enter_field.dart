import '../effects/effect.dart';
import '../models/card_object.dart';

/// Has an onEnterField effect.
mixin OnEnterField on CardObject {
  /// List of effects triggered when this enters the field.
  List<Effect> get onEnterFieldEffects;
}
