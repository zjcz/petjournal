import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/models/pet_model.dart';
import 'package:flutter/material.dart';
import 'package:petjournal/app/species/models/species_model.dart';
import 'package:petjournal/data/lookups/species_lookup.dart';
import 'package:petjournal/helpers/date_helper.dart';

// Widget to display pet info
class PetWidget extends ConsumerStatefulWidget {
  final PetModel pet;

  const PetWidget({super.key, required this.pet});

  @override
  ConsumerState<PetWidget> createState() => _PetWidgetState();
}

class _PetWidgetState extends ConsumerState<PetWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> listViewItems = [
      _buildListViewItem("Name", widget.pet.name),
      _buildListViewItem("Species", _getSpeciesName(widget.pet.speciesId)),
      _buildListViewItem("Breed", widget.pet.breed),
      _buildListViewItem("Colour", widget.pet.colour),
      _buildListViewItem(
        "Age",
        widget.pet.dob == null ? 'unknown' : widget.pet.getAge()!,
      ),
      if (widget.pet.dob != null)
        _buildListViewItem(
          "Date of Birth",
          '${DateHelper.formatDate(widget.pet.dob!)}${widget.pet.dobEstimate ? ' (estimated)' : ''}',
        ),
      _buildListViewItem("Diet", widget.pet.diet ?? '', isThreeLine: true),
      _buildListViewItem(
        "History",
        widget.pet.history ?? '',
        isThreeLine: true,
      ),
      _buildListViewItem("Notes", widget.pet.notes ?? '', isThreeLine: true),
      _buildListViewItem(
        "Neutered",
        widget.pet.isNeutered
            ? "Yes ${widget.pet.neuterDate == null ? '' : " - ${DateHelper.formatDate(widget.pet.neuterDate!)}"}"
            : "No",
      ),
      _buildListViewItem("Status", widget.pet.status.niceName),
      _buildListViewItem(
        "Microchipped?",
        widget.pet.isMicrochipped ? "Yes" : "No",
      ),
    ];

    if (widget.pet.isMicrochipped) {
      listViewItems.add(
        _buildListViewItem(
          "Microchip Number",
          widget.pet.microchipNumber ?? '',
        ),
      );
      if (widget.pet.microchipDate != null) {
        listViewItems.add(
          _buildListViewItem(
            "Microchip Date",
            DateHelper.formatDate(widget.pet.microchipDate!),
          ),
        );
      }
      listViewItems.add(
        _buildListViewItem(
          "Microchip Company",
          widget.pet.microchipCompany ?? '',
        ),
      );
      listViewItems.add(
        _buildListViewItem("Microchip Notes", widget.pet.microchipNotes ?? ''),
      );
    }

    return ListView(children: listViewItems);
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

  /// // lookup the name for the species
  String _getSpeciesName(int speciesId) {
    SpeciesModel? s = SpeciesLookup().getSpecies(speciesId);
    if (s == null) {
      return '';
    }

    return s.name;
  }
}
