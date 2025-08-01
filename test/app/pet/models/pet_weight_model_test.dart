import 'package:petjournal/app/pet/models/pet_weight_model.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:test/test.dart';

void main() {
  group('PetWeightModel', () {
    test('When weight is set to metric, niceName should return kg', () {
      // ARRANGE
      PetWeightModel petWeight = PetWeightModel(
        petId: 1,
        weight: 1.5,
        weightUnit: WeightUnits.metric,
        date: DateTime.now(),
      );

      // ACT
      String niceName = petWeight.niceName();

      // ASSERT
      expect(niceName, '1.5 kg');
    });

    test('When weight is set to imperial, niceName should return lbs', () {
      // ARRANGE
      PetWeightModel petWeight = PetWeightModel(
        petId: 1,
        weight: 7.2,
        weightUnit: WeightUnits.imperial,
        date: DateTime.now(),
      );

      // ACT
      String niceName = petWeight.niceName();

      // ASSERT
      expect(niceName, '7.2 lbs');
    });
  });
}
