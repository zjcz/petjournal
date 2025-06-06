import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/controller/pet_microchips_controller.dart';
import 'package:petjournal/app/pet/models/pet_microchip_model.dart';
import 'package:flutter/material.dart';
import 'package:petjournal/helpers/date_helper.dart';
import 'package:petjournal/widgets/loading_widget.dart';

// Widget to display pet microchip info
class PetMicrochipWidget extends ConsumerStatefulWidget {
  final int petId;

  const PetMicrochipWidget({super.key, required this.petId});

  @override
  ConsumerState<PetMicrochipWidget> createState() => _PetMicrochipWidgetState();
}

class _PetMicrochipWidgetState extends ConsumerState<PetMicrochipWidget> {
  @override
  Widget build(BuildContext context) {
    final petMicrochips = ref.watch(
      petMicrochipsControllerProvider(widget.petId),
    );

    return petMicrochips.when(
      data: (microchips) {
        if (microchips == null || microchips.isEmpty) {
          return const Center(child: Text('No microchip data available'));
        }
        return _buildPetMicrochipDataView(microchips.first);
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => LoadingWidget(labelText: 'Loading Microchip Info...'),
    );
  }

  Widget _buildPetMicrochipDataView(PetMicrochipModel microchipInfo) {
    return ListView(
      children: [
        _buildListViewItem(
          "Microchip Number",
          microchipInfo.microchipNumber ?? 'Unknown',
        ),
        _buildListViewItem("Company", microchipInfo.microchipCompany ?? ''),

        if (microchipInfo.microchipDate != null)
          _buildListViewItem(
            "Date",
            DateHelper.formatDate(microchipInfo.microchipDate!),
          ),
        _buildListViewItem(
          "Notes",
          microchipInfo.microchipNotes ?? '',
          isThreeLine: true,
        ),
      ],
    );
  }

  Widget _buildListViewItem(
    String title,
    String value, {
    bool isThreeLine = false,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      isThreeLine: isThreeLine,
    );
  }
}
