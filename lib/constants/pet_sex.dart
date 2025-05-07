enum PetSex implements Comparable<PetSex> {
  female(dataValue: 0),
  male(dataValue: 1),
  unknown(dataValue: 2);

  final int dataValue;

  const PetSex({required this.dataValue});

  static PetSex fromDataValue(int dataValue) {
    switch (dataValue) {
      case 0:
        return PetSex.female;
      case 1:
        return PetSex.male;
      case 2:
        return PetSex.unknown;
      default:
        throw Exception('Unknown data value for PetSex: $dataValue');
    }
  }

  @override
  int compareTo(PetSex other) {
    return dataValue.compareTo(other.dataValue);
  }
}
