import 'package:flutter/material.dart';
import 'package:petjournal/constants/pet_sex.dart';

class PetSexDropdown extends StatelessWidget {
  final String labelText;
  final PetSex? selectedValue;
  final void Function(PetSex?) onChanged;
  final String? Function(PetSex?) onValidate;

  const PetSexDropdown({
    super.key,
    required this.labelText,
    required this.selectedValue,
    required this.onChanged,
    required this.onValidate,

  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<PetSex>(
      initialValue: selectedValue,
      items: PetSex.values.map((PetSex sex) {
        return DropdownMenuItem<PetSex>(
          value: sex,
          child: Text(sex.niceName), // e.g., "male"
        );
      }).toList(),
      onChanged: onChanged,
      validator: onValidate,
      decoration: InputDecoration(labelText: labelText),
    );
  }
}
