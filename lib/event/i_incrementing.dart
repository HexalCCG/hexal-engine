import 'event.dart';

abstract class IIncrementing {
  int get counter;
  Event get increment;
}
