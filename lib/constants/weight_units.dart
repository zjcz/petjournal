enum WeightUnits {
  metric(niceName: 'Metric (kg)', unitName: 'kg'),
  imperial(niceName: 'Imperial (lbs)', unitName: 'lbs');

  final String niceName;
  final String unitName;

  const WeightUnits({required this.niceName, required this.unitName});
}
