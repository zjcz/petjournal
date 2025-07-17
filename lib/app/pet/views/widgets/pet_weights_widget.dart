import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petjournal/app/pet/controller/pet_weights_controller.dart';
import 'package:petjournal/app/pet/models/pet_weight_model.dart';
import 'package:flutter/material.dart';
import 'package:petjournal/constants/custom_styles.dart';
import 'package:petjournal/helpers/date_helper.dart';
import 'package:petjournal/route_config.dart';
import 'package:petjournal/widgets/loading_widget.dart';

// Widget to display pet weights
class PetWeightsWidget extends ConsumerStatefulWidget {
  final int petId;

  const PetWeightsWidget({super.key, required this.petId});

  @override
  ConsumerState<PetWeightsWidget> createState() => _PetWeightsWidgetState();
}

class _PetWeightsWidgetState extends ConsumerState<PetWeightsWidget> {
  @override
  Widget build(BuildContext context) {
    final petWeights = ref.watch(petWeightsControllerProvider(widget.petId));

    return petWeights.when(
      data: (weights) {
        if (weights.isEmpty) {
          return const Center(child: Text('No weight data available.'));
        }
        return Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentWeight(weights.first),
            _buildPetWeightsTable(weights),
          ],
        );
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => LoadingWidget(labelText: 'Loading Weight Info...'),
    );
  }

  Widget _buildCurrentWeight(PetWeightModel currentWeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current Weight:', style: CustomStyles.dataTableHeaderTextStyle),
        Text(
          '${currentWeight.weight.toStringAsFixed(2)} ${currentWeight.weightUnit.niceName}',
        ),
        if (currentWeight.notes != null && currentWeight.notes!.isNotEmpty)
          Text('Notes: ${currentWeight.notes}'),
      ],
    );
  }

  Widget _buildPetWeightsTable(List<PetWeightModel> weights) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showCheckboxColumn: false,
        sortColumnIndex: 0,
        columns: const <DataColumn>[
          DataColumn(
            label: Text('Date', style: CustomStyles.dataTableHeaderTextStyle),
          ),
          DataColumn(
            label: Text('Weight', style: CustomStyles.dataTableHeaderTextStyle),
          ),
          DataColumn(
            label: Text('Notes', style: CustomStyles.dataTableHeaderTextStyle),
          ),
        ],
        rows: buildDataRows(weights),
      ),
    );
  }

  List<DataRow> buildDataRows(List<PetWeightModel> weights) {
    List<DataRow> dataRows = List<DataRow>.generate(weights.length, (
      int index,
    ) {
      PetWeightModel weight = weights[index];
      return DataRow(
        cells: <DataCell>[
          DataCell(Text(DateHelper.formatDate(weight.date))),

          DataCell(
            Text(
              '${weight.weight.toStringAsFixed(2)} ${weight.weightUnit.niceName}',
            ),
          ),
          DataCell(Text(weight.notes ?? '')),
        ],
        onSelectChanged: (value) async {
          await context.push(
            '${RouteDefs.editPetWeight}/${weight.petId}',
            extra: weight,
          );
        },
      );
    });

    return dataRows;
  }
}
