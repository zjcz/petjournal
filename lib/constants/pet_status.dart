enum PetStatus {
  active(niceName: 'Active'),
  deceased(niceName: 'Deceased'),
  rehomed(niceName: 'Rehomed'),
  missing(niceName: 'Missing');

  final String niceName;

  const PetStatus({required this.niceName});
}
