import 'package:flutter/material.dart';
import 'package:petjournal/constants/frequency_type.dart';

class FrequencyTypeDropdown extends StatelessWidget {
  final FrequencyType? value;
  final void Function(FrequencyType?) onChanged;
  final String labelText;
  final String? Function(FrequencyType?)? validator;

  const FrequencyTypeDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.labelText = "Frequency Type",
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<FrequencyType>(
      decoration: InputDecoration(labelText: labelText),
      value: value,
      items: FrequencyType.values.map((unit) {
        return DropdownMenuItem(value: unit, child: Text(unit.niceName));
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
