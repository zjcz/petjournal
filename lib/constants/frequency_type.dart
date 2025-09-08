enum FrequencyType {
  daily(niceName: 'daily'),
  weekly(niceName: 'weekly'),
  monthly(niceName: 'monthly'),
  yearly(niceName: 'yearly');

  final String niceName;

  const FrequencyType({required this.niceName});
}