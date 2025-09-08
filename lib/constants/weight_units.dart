enum WeightUnits {
  metric(niceName: 'Metric (kg)'),
  imperial(niceName: 'Imperial (lbs)');

  final String niceName;

  const WeightUnits({required this.niceName});
}
