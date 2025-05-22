enum PetSex implements Comparable<PetSex> {
  female(dataValue: 0, niceName: 'female'),
  male(dataValue: 1, niceName: 'male'),
  unknown(dataValue: 2, niceName: 'unknown');

  final int dataValue;
  final String niceName;

  const PetSex({required this.dataValue, required this.niceName});

  static PetSex fromDataValue(int dataValue) {
    return PetSex.values.firstWhere(
      (sex) => sex.dataValue == dataValue,
      orElse:
          () => throw Exception('Unknown data value for PetSex: $dataValue'),
    );
  }

  @override
  int compareTo(PetSex other) {
    return dataValue.compareTo(other.dataValue);
  }
}
