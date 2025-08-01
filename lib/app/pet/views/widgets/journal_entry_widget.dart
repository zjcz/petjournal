import 'package:flutter/material.dart';
import 'package:petjournal/app/pet/models/journal_model.dart';
import 'package:petjournal/app/pet/models/pet_model.dart';
import 'package:petjournal/constants/linked_record_type.dart';
import 'package:petjournal/data/lookups/pet_lookup.dart';
import 'package:petjournal/helpers/date_helper.dart';

/// This widget shows the details for a single journal entry, including
/// tags and pets
class JournalEntryWidget extends StatelessWidget {
  final JournalModel journalEntry;
  final Function(JournalModel) onTap;
  final int? hidePetId;
  final Map<LinkedRecordType, Icon> linkedRecordIcons = const {
    LinkedRecordType.pet: Icon(Icons.pets),
    LinkedRecordType.medication: Icon(Icons.medication),
    LinkedRecordType.weight: Icon(Icons.balance),
    LinkedRecordType.vaccination: Icon(Icons.vaccines),
  };

  const JournalEntryWidget({
    super.key,
    required this.journalEntry,
    required this.onTap,
    this.hidePetId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => onTap(journalEntry),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ?_buildLinkedRecordDetails(journalEntry),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    journalEntry.entryText,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    journalEntry.createdDateTime == null
                        ? ''
                        : DateHelper.formatDateTime(
                            journalEntry.createdDateTime!,
                          ),
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ?_buildPetChips(journalEntry.petIdList),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 5.0,
                    runSpacing: 0.0,
                    children: journalEntry.tags
                        .map(
                          (tagText) => Chip(
                            avatar: CircleAvatar(
                              backgroundColor: Colors.grey.shade200,
                              child: const Text('#'),
                            ),
                            label: Text(tagText),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget? _buildLinkedRecordDetails(JournalModel journalEntry) {
    if (journalEntry.linkedRecordId == null) return null;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              linkedRecordIcons[journalEntry.linkedRecordType] ??
              const Icon(Icons.pets),
        ),
        Text(
          journalEntry.linkedRecordTitle ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  /// Build the collection of chips highlighting the pets linked to this journal entry
  Widget? _buildPetChips(List<int> petIdList) {
    List<Chip> chips = [];

    for (int petId in petIdList) {
      Chip? chip = _buildPetChip(petId);
      if (chip != null) {
        chips.add(chip);
      }
    }

    if (chips.isEmpty) {
      return null;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Wrap(spacing: 5.0, runSpacing: 6.0, children: chips),
    );
  }

  /// build the chip for a pet
  Chip? _buildPetChip(int petId) {
    if (hidePetId != null && hidePetId == petId) {
      return null;
    }

    PetModel? p = PetLookup().getPet(petId);
    if (p == null) {
      return null;
    }

    return Chip(
      avatar: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        child: Text(p.name.substring(0, 1)),
      ),
      label: Text(p.name),
    );
  }
}
