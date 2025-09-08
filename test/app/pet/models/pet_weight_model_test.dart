import 'package:petjournal/app/pet/models/pet_weight_model.dart';
import 'package:petjournal/helpers/imperial_weight.dart';
import 'package:test/test.dart';

void main() {
  group('PetWeightModel', () {
    test('When weight is set to metric and is whole number, niceName should return kg', () {
      // ARRANGE
      PetWeightModel petWeight = PetWeightModel(
        petId: 1,
        weightKg: 5,
        date: DateTime.now(),
      );

      // ACT
      String niceName = petWeight.niceName(true);

      // ASSERT
      expect(niceName, '5 kg');
    });

        test('When weight is set to metric and has fractions, niceName should return kg', () {
      // ARRANGE
      PetWeightModel petWeight = PetWeightModel(
        petId: 1,
        weightKg: 1.5,
        date: DateTime.now(),
      );

      // ACT
      String niceName = petWeight.niceName(true);

      // ASSERT
      expect(niceName, '1.500 kg');
    });

    test('When weight is set to imperial, niceName should return lbs', () {
      // ARRANGE
      PetWeightModel petWeight = PetWeightModel(
        petId: 1,
        weightKg: 7.2,
        date: DateTime.now(),
      );

      // ACT
      String niceName = petWeight.niceName(false);

      // ASSERT
      expect(niceName, ImperialWeight.fromKg(7.2).toString());
    });
  });
}
