import '../models/card_object.dart';
import 'sample/set_00.dart';

/// Container for functions creating cards from json.
const Map<int, Map<int, CardObject Function(List<dynamic>)>> setBuilders = {
  0: set_00,
};
