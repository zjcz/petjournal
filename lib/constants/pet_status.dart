enum PetStatus implements Comparable<PetStatus> {
  active(dataValue: 0),
  deceased(dataValue: 1),
  rehomed(dataValue: 2);

  final int dataValue;

  const PetStatus({required this.dataValue});

  static PetStatus fromDataValue(int dataValue) {
    switch (dataValue) {
      case 0:
        return PetStatus.active;
      case 1:
        return PetStatus.deceased;
      case 2:
        return PetStatus.rehomed;        
      default:
        throw Exception('Unknown data value for PetStatus: $dataValue');
    }
  }

  @override
  int compareTo(PetStatus other) {
    return dataValue.compareTo(other.dataValue);
  }
}
