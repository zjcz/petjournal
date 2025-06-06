import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/controller/pet_meds_controller.dart';
import 'package:petjournal/app/pet/models/pet_med_model.dart';
import 'package:flutter/material.dart';
import 'package:petjournal/constants/custom_styles.dart';
import 'package:petjournal/helpers/date_helper.dart';
import 'package:petjournal/widgets/loading_widget.dart';

// Widget to display pet meds
class PetMedsWidget extends ConsumerStatefulWidget {
  final int petId;

  const PetMedsWidget({super.key, required this.petId});

  @override
  ConsumerState<PetMedsWidget> createState() => _PetMedsWidgetState();
}

class _PetMedsWidgetState extends ConsumerState<PetMedsWidget> {
  @override
  Widget build(BuildContext context) {
    final petMeds = ref.watch(petMedsControllerProvider(widget.petId));

    return petMeds.when(
      data: (medications) {
        if (medications == null || medications.isEmpty) {
          return const Center(child: Text('No medication data available'));
        }
        return _buildPetMedsTable(medications);
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => LoadingWidget(labelText: 'Loading Medication Info...'),
    );
  }

  Widget _buildPetMedsTable(List<PetMedModel> medications) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showCheckboxColumn: false,
        sortColumnIndex: 0,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Medication',
              style: CustomStyles.dataTableHeaderTextStyle,
            ),
          ),
          DataColumn(
            label: Text('Dosage', style: CustomStyles.dataTableHeaderTextStyle),
          ),
          DataColumn(
            label: Text('Start', style: CustomStyles.dataTableHeaderTextStyle),
          ),
          DataColumn(
            label: Text('End', style: CustomStyles.dataTableHeaderTextStyle),
          ),
          DataColumn(
            label: Text('Notes', style: CustomStyles.dataTableHeaderTextStyle),
          ),
        ],
        rows: buildDataRows(medications),
      ),
    );
  }

  List<DataRow> buildDataRows(List<PetMedModel> medications) {
    List<DataRow> dataRows = List<DataRow>.generate(medications.length, (
      int index,
    ) {
      PetMedModel medication = medications[index];
      return DataRow(
        cells: <DataCell>[
          DataCell(Text(medication.name)),
          DataCell(Text(medication.dose)),
          DataCell(Text(DateHelper.formatDate(medication.startDate))),
          if (medication.endDate != null)
            DataCell(Text(DateHelper.formatDate(medication.endDate!))),
          DataCell(Text(medication.notes ?? '')),
        ],
      );
    });

    return dataRows;
  }
}
