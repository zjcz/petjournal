enum WeightUnits implements Comparable<WeightUnits> {
  metric(dataValue: 0),
  imperial(dataValue: 1);

  final int dataValue;

  const WeightUnits({required this.dataValue});

  static WeightUnits fromDataValue(int dataValue) {
    switch (dataValue) {
      case 0:
        return WeightUnits.metric;
      case 1:
        return WeightUnits.imperial;
      default:
        throw Exception('Unknown data value for WeightUnits: $dataValue');
    }
  }

  @override
  int compareTo(WeightUnits other) {
    return dataValue.compareTo(other.dataValue);
  }
}
