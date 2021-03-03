import 'package:hexal_engine/model/mana_amount.dart';
import 'package:test/test.dart';

void main() {
  group('Mana amount', () {
    test('addition works.', () {
      final one = const ManaAmount(fire: 2, earth: 1, neutral: 1);
      final two = const ManaAmount(air: 1, fire: 1, water: 1, neutral: 1);

      expect(
        one + two,
        const ManaAmount(fire: 3, earth: 1, air: 1, water: 1, neutral: 2),
      );
    });
    test('filled by returns true for a greater amount.', () {
      final one = const ManaAmount(fire: 2, neutral: 1);
      final two = const ManaAmount(fire: 3, neutral: 2);

      expect(one.isFilledBy(two), true);
    });
    test('filled by returns true for neutral mana filled by a colour.', () {
      final one = const ManaAmount(air: 1, neutral: 1);
      final two = const ManaAmount(air: 2);

      expect(one.isFilledBy(two), true);
    });
    test('filled by returns true for an equal amount.', () {
      final one = const ManaAmount(water: 2, neutral: 1);
      final two = const ManaAmount(water: 2, neutral: 1);

      expect(one.isFilledBy(two), true);
    });
    test('filled by returns false for an inadequate amount.', () {
      final one = const ManaAmount(water: 2, neutral: 1);
      final two = const ManaAmount(water: 1, neutral: 1);

      expect(one.isFilledBy(two), false);
    });
  });
}
