import 'package:flutter/material.dart';
import 'package:petjournal/constants/weight_units.dart';

class WeightUnitsDropdown extends StatelessWidget {
  final WeightUnits? value;
  final void Function(WeightUnits?) onChanged;
  final String labelText;

  const WeightUnitsDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.labelText = "Weight Units",
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<WeightUnits>(
      decoration: InputDecoration(labelText: labelText),
      initialValue: value,
      items:
          WeightUnits.values.map((unit) {
            return DropdownMenuItem(value: unit, child: Text(unit.niceName));
          }).toList(),
      onChanged: onChanged,
    );
  }
}
