enum PetStatus implements Comparable<PetStatus> {
  active(dataValue: 0, niceName: 'Active'),
  deceased(dataValue: 1, niceName: 'Deceased'),
  rehomed(dataValue: 2, niceName: 'Rehomed'),
  missing(dataValue: 3, niceName: 'Missing');

  final int dataValue;
  final String niceName;

  const PetStatus({required this.dataValue, required this.niceName});

  static PetStatus fromDataValue(int dataValue) {
    return PetStatus.values.firstWhere(
      (status) => status.dataValue == dataValue,
      orElse:
          () => throw Exception('Unknown data value for PetStatus: $dataValue'),
    );
  }

  @override
  int compareTo(PetStatus other) {
    return dataValue.compareTo(other.dataValue);
  }
}
