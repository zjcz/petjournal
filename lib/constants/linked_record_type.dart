enum LinkedRecordType {
  pet(niceName: 'Pet'),
  medication(niceName: 'Medication'),
  weight(niceName: 'Weight'),
  vaccination(niceName: 'Vaccination');

  final String niceName;

  const LinkedRecordType({required this.niceName});
}
