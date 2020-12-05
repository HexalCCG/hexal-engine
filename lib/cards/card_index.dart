import '../models/card_object.dart';
import '00_token/set_00.dart';
import '01_basic/set_01.dart';

/// Container for functions creating cards from json.
const Map<int, Map<int, CardObject Function(List<dynamic>)>> setBuilders = {
  0: set_00,
  1: set_01,
};
