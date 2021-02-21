import '../cards/00_token/set_00.dart';
import '../cards/01_basic/set_01.dart';
import '../models/card.dart';

/// Container for functions creating cards from json.
const Map<int, Map<int, Card Function(List<dynamic>)>> setBuilders = {
  0: set_00,
  1: set_01,
};
