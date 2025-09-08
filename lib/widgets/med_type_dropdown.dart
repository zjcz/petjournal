import 'package:flutter/material.dart';
import 'package:petjournal/constants/med_type.dart';

class MedTypeDropdown extends StatelessWidget {
  final MedType? value;
  final void Function(MedType?) onChanged;
  final String labelText;
  final String? Function(MedType?)? validator;

  const MedTypeDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.labelText = "Medication Type",
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<MedType>(
      decoration: InputDecoration(labelText: labelText),
      value: value,
      items: MedType.values.map((unit) {
        return DropdownMenuItem(value: unit, child: Text(unit.niceName));
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
