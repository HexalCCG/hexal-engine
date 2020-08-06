import '../effect/effect.dart';

/// Has an onEnterField effect.
abstract class IOnEnterField {
  /// List of effects triggered when this enters the field.
  List<Effect> get onEnterFieldEffects;
}
