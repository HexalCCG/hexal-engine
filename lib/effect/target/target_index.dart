import 'creature_target.dart';
import 'target.dart';

/// Container for functions creating cards from json.
Map<Type, Target Function(List<dynamic>)> targetBuilders = {
  CreatureTarget: CreatureTarget.fromJson,
};
