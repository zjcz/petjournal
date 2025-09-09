import 'package:flutter/material.dart';
import 'package:petjournal/constants/pet_status.dart';

class PetStatusDropdown extends StatelessWidget {
  final String labelText;
  final PetStatus? selectedValue;
  final void Function(PetStatus?) onChanged;
  final String? Function(PetStatus?) onValidate;

  const PetStatusDropdown({
    super.key,
    required this.labelText,
    required this.selectedValue,
    required this.onChanged,
    required this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<PetStatus>(
      initialValue: selectedValue,
      items: PetStatus.values.map((PetStatus status) {
        return DropdownMenuItem<PetStatus>(
          value: status,
          child: Text(status.niceName),
        );
      }).toList(),
      onChanged: onChanged,
      validator: onValidate,
      decoration: InputDecoration(labelText: labelText),
    );
  }
}
