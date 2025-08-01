enum WeightUnits implements Comparable<WeightUnits> {
  metric(dataValue: 0, niceName: 'Metric (kg)', unitName: 'kg'),
  imperial(dataValue: 1, niceName: 'Imperial (lbs)', unitName: 'lbs');

  final int dataValue;
  final String niceName;
  final String unitName;

  const WeightUnits({
    required this.dataValue,
    required this.niceName,
    required this.unitName,
  });

  static WeightUnits fromDataValue(int dataValue) {
    return WeightUnits.values.firstWhere(
      (unit) => unit.dataValue == dataValue,
      orElse: () =>
          throw Exception('Unknown data value for WeightUnits: $dataValue'),
    );
  }

  @override
  int compareTo(WeightUnits other) {
    return dataValue.compareTo(other.dataValue);
  }
}
