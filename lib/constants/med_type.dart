enum MedType {
  cream(niceName: 'cream / lotion'),
  injection(niceName: 'mg (injection)'),
  oral(niceName: 'mg (oral)'),
  tablet(niceName: 'tablet');

  final String niceName;

  const MedType({required this.niceName});
}
