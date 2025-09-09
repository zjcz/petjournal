import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/species/controllers/species_controller.dart';
import 'package:petjournal/app/species/models/species_model.dart';

class SpeciesDropdown extends ConsumerWidget {
  final SpeciesModel? species;
  final Function(SpeciesModel?) onChanged;
  final String? Function(SpeciesModel?) onValidate;
  final String? labelText;

  const SpeciesDropdown({
    super.key,
    this.species,
    required this.onChanged,
    required this.onValidate,
    this.labelText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speciesList = ref.watch(speciesControllerProvider);
    return speciesList.when(
      data: (speciesData) {
        if (speciesData.isEmpty) {
          return const Center(
            child: Text('No species found.  Click + to add one'),
          );
        }
        return DropdownButtonFormField<SpeciesModel>(
          key: GlobalKey<FormFieldState>(),
          decoration: InputDecoration(labelText: labelText ?? "Species"),
          initialValue: species,
          items: speciesData.map((s) {
            return DropdownMenuItem<SpeciesModel>(
              value: s,
              child: Text(s.name),
            );
          }).toList(),
          validator: onValidate,
          onChanged: onChanged,
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) =>
          Center(child: Text('Error loading data: $error')),
    );
  }
}
