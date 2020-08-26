import 'package:hexal_engine/events/attack_event.dart';

import 'event.dart';

/// Container for functions creating cards from json.
const Map<String, Event Function(List<dynamic>)> eventBuilders = {
  AttackEvent: AttackEvent.fromJson,
};
