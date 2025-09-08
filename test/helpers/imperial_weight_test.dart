import 'package:petjournal/helpers/imperial_weight.dart';
import 'package:test/test.dart';

void main() {
  group('Declare ImperialWeight', () {
    test('Should convert 17 ounces to 1 pound imperial weight', () {
      // ACT
      final weight = ImperialWeight.fromImperial(0, 17);

      // ASSERT
      expect(weight.pounds, 1);
      expect(weight.ounces, 1);
    });

    test('Should convert 33 ounces to 2 pound imperial weight', () {
      // ACT
      final weight = ImperialWeight.fromImperial(0, 33);

      // ASSERT
      expect(weight.pounds, 2);
      expect(weight.ounces, 1);
    });
  });

  group('Test Metric to Imperial Weight Conversions', () {
    test('Should convert 0.453592 kg to 1 pound imperial weight', () {
      // ARRANGE
      final weightKg = 0.453592;

      // ACT
      final weight = ImperialWeight.fromKg(weightKg);

      // ASSERT
      expect(weight.pounds, 1);
      expect(weight.ounces, 0);
    });

    test('Should convert 1 kg to 2 pounds 3.274 ounces imperial weight', () {
      // ARRANGE
      final weightKg = 1.0;

      // ACT
      final weight = ImperialWeight.fromKg(weightKg);

      // ASSERT
      expect(weight.pounds, 2);
      expect(weight.ounces.toStringAsFixed(3), '3.274');
    });
  });

  group('Test Imperial Weight to Metric Conversions', () {
    test('Should convert 1 pound imperial to 0.453592 kg weight', () {
      // ACT
      final weight = ImperialWeight.fromImperial(1, 0);

      // ASSERT
      expect(weight.toKg(), 0.453592);
    });

    test('Should convert 2 pounds 2 ounce imperial weight to 0.964 kg', () {
      // ACT
      final weight = ImperialWeight.fromImperial(2, 2);

      // ASSERT
      expect(weight.toKg().toStringAsFixed(3), '0.964');
    });

    test('Should convert 0 pounds 17 ounces imperial weight to 0.482 kg', () {
      // ACT
      final weight = ImperialWeight.fromImperial(0, 17);

      // ASSERT
      expect(weight.toKg().toStringAsFixed(3), '0.482');
    });

    test('Should convert 1 pounds 1 ounces imperial weight to 0.482 kg', () {
      // ACT
      final weight = ImperialWeight.fromImperial(1, 1);

      // ASSERT
      expect(weight.toKg().toStringAsFixed(3), '0.482');
    });

    test('Should convert 1 pounds 7.5 ounces imperial weight to 0.666 kg', () {
      // ACT
      final weight = ImperialWeight.fromImperial(1, 7.5);

      // ASSERT
      expect(weight.toKg().toStringAsFixed(3), '0.666');
    });
  });

  group('Test converting from Imperial Weight to Metric and back again', () {
    test(
      'Should convert to the same oz imperial weight when converted back and forth',
      () {
        // ARRANGE
        final originalWeight = ImperialWeight.fromImperial(0, 5);

        // ACT
        final fromKgWeight = ImperialWeight.fromKg(originalWeight.toKg());

        // ASSERT
        expect(fromKgWeight.pounds, originalWeight.pounds);
        expect(fromKgWeight.ounces, originalWeight.ounces);
      },
    );

    test(
      'Should convert to the same imperial weight when converted back and forth',
      () {
        // ARRANGE
        final originalWeight = ImperialWeight.fromImperial(0, 17);

        // ACT
        final fromKgWeight = ImperialWeight.fromKg(originalWeight.toKg());

        // ASSERT
        expect(fromKgWeight.pounds, originalWeight.pounds);
        expect(fromKgWeight.ounces, originalWeight.ounces);
      },
    );

    test(
      'Should convert to the same pound and ounce imperial weight when converted back and forth',
      () {
        for (double i = 0.1; i < 160; i += 0.1) {
          final originalWeight = ImperialWeight.fromImperial(0, i);

          // ACT
          final fromKgWeight = ImperialWeight.fromKg(originalWeight.toKg());

          // ASSERT
          expect(
            fromKgWeight.pounds.toStringAsFixed(3),
            originalWeight.pounds.toStringAsFixed(3),
          );
          expect(
            fromKgWeight.ounces.toStringAsFixed(3),
            originalWeight.ounces.toStringAsFixed(3),
          );
        }
      },
    );
  });

  group('Test converting imperial weights to string', () {
    test(
      'Should only show pounds if ounces is zero when converted to string',
      () {
        // ARRANGE
        final originalWeight = ImperialWeight.fromImperial(1, 0);

        // ACT
        final stringName = originalWeight.toString();

        // ASSERT
        expect(stringName, '1 lb');
      },
    );
    test('Should show pounds and ounces when converted to string', () {
      // ARRANGE
      final originalWeight = ImperialWeight.fromImperial(1, 5);

      // ACT
      final stringName = originalWeight.toString();

      // ASSERT
      expect(stringName, '1 lb, 5 oz');
    });

    test(
      'Should show pounds and ounces including decimals when converted to string',
      () {
        // ARRANGE
        final originalWeight = ImperialWeight.fromImperial(1, 5.3);

        // ACT
        final stringName = originalWeight.toString();

        // ASSERT
        expect(stringName, '1 lb, 5.3 oz');
      },
    );
  });
}
