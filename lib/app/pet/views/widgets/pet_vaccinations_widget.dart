import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/controller/pet_vaccinations_controller.dart';
import 'package:flutter/material.dart';
import 'package:petjournal/app/pet/models/pet_vaccination_model.dart';
import 'package:petjournal/constants/custom_styles.dart';
import 'package:petjournal/helpers/date_helper.dart';
import 'package:petjournal/widgets/loading_widget.dart';

// Widget to display pet vaccinations
class PetVaccinationsWidget extends ConsumerStatefulWidget {
  final int petId;

  const PetVaccinationsWidget({super.key, required this.petId});

  @override
  ConsumerState<PetVaccinationsWidget> createState() =>
      _PetVaccinationsWidgetState();
}

class _PetVaccinationsWidgetState extends ConsumerState<PetVaccinationsWidget> {
  @override
  Widget build(BuildContext context) {
    final petVaccinations = ref.watch(
      petVaccinationsControllerProvider(widget.petId),
    );

    return petVaccinations.when(
      data: (vaccinations) {
        if (vaccinations.isEmpty) {
          return const Center(child: Text('No vaccinations data available'));
        }
        return _buildPetVaccinationsTable(vaccinations);
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => LoadingWidget(labelText: 'Loading Vaccination Info...'),
    );
  }

  Widget _buildPetVaccinationsTable(List<PetVaccinationModel> vaccinations) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showCheckboxColumn: false,
        sortColumnIndex: 0,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Vaccination',
              style: CustomStyles.dataTableHeaderTextStyle,
            ),
          ),
          DataColumn(
            label: Text(
              'Administered On',
              style: CustomStyles.dataTableHeaderTextStyle,
            ),
          ),
          DataColumn(
            label: Text('Expiry', style: CustomStyles.dataTableHeaderTextStyle),
          ),
          DataColumn(
            label: Text('Notes', style: CustomStyles.dataTableHeaderTextStyle),
          ),
        ],
        rows: buildDataRows(vaccinations),
      ),
    );
  }

  List<DataRow> buildDataRows(List<PetVaccinationModel> vaccinations) {
    List<DataRow> dataRows = List<DataRow>.generate(vaccinations.length, (
      int index,
    ) {
      PetVaccinationModel vaccination = vaccinations[index];
      return DataRow(
        cells: <DataCell>[
          DataCell(Text(vaccination.name)),
          DataCell(Text(DateHelper.formatDate(vaccination.administeredDate))),
          DataCell(
            Text(
              vaccination.expiryDate == null
                  ? ''
                  : DateHelper.formatDate(vaccination.expiryDate!),
            ),
          ),
          DataCell(Text(vaccination.notes ?? '')),
        ],
      );
    });

    return dataRows;
  }
}
