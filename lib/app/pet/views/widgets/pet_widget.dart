import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/models/pet_model.dart';
import 'package:flutter/material.dart';
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
    return ListView(
      children: [
        _buildListViewItem("Name", widget.pet.name),
        _buildListViewItem("Species", widget.pet.species.name),
        _buildListViewItem("Breed", widget.pet.breed),
        _buildListViewItem("Colour", widget.pet.colour),        
        _buildListViewItem(
          "Age",
          widget.pet.age == null ? 'unknown' : widget.pet.age.toString(),
        ),
        if (widget.pet.dob != null)
          _buildListViewItem(
            "Date of Birth",
            DateHelper.formatDate(widget.pet.dob!),
          ),
        _buildListViewItem("Diet", widget.pet.diet ?? '', isThreeLine: true),
        _buildListViewItem("History", widget.pet.history ?? '', isThreeLine: true),
        _buildListViewItem("Notes", widget.pet.notes ?? '', isThreeLine: true),
        _buildListViewItem("Neutered", widget.pet.isNeutered ? "Yes ${widget.pet.neuterDate == null ? '' : " - ${DateHelper.formatDate(widget.pet.neuterDate!)}"}" : "No"),
        _buildListViewItem("Status", widget.pet.status.niceName),
      ],
    );
  }

  Widget _buildListViewItem(String title, String value , {bool isThreeLine = false}) {
    return ListTile(title: Text(title), subtitle: Text(value), isThreeLine: isThreeLine,);
  }
}
