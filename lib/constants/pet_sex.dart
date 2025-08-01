enum PetSex {
  female(niceName: 'female'),
  male(niceName: 'male'),
  unknown(niceName: 'unknown');

  final String niceName;

  const PetSex({required this.niceName});
}
