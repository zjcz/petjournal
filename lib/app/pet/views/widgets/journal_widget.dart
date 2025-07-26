import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petjournal/route_config.dart';
import 'package:petjournal/app/pet/controller/journal_controller.dart';
import 'package:petjournal/app/pet/models/journal_model.dart';
import 'package:flutter/material.dart';
import 'package:petjournal/app/pet/views/widgets/journal_entry_widget.dart';
import 'package:petjournal/widgets/loading_widget.dart';

// Widget to display pet journal entries
class JournalWidget extends ConsumerStatefulWidget {
  final int petId;

  const JournalWidget({super.key, required this.petId});

  @override
  ConsumerState<JournalWidget> createState() => _JournalWidgetState();
}

class _JournalWidgetState extends ConsumerState<JournalWidget> {
  @override
  Widget build(BuildContext context) {
    final journalEntries = ref.watch(journalControllerProvider(widget.petId));

    return journalEntries.when(
      data: (journals) {
        if (journals.isEmpty) {
          return const Center(child: Text('No journal entries available.'));
        }
        return _buildJournalEntryList(journals);
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => LoadingWidget(labelText: 'Loading Journal Info...'),
    );
  }

  Widget _buildJournalEntryList(List<JournalModel> journals) {
    return ListView.builder(
      itemCount: journals.length,
      itemBuilder: (context, index) {
        final journal = journals[index];
        return JournalEntryWidget(
          journalEntry: journal,
          onTap: (journal) async {
            await context.push(
              '${RouteDefs.editJournalEntry}/${widget.petId}',
              extra: journal,
            );
          },
          hidePetId: widget.petId,
        );
      },
    );
  }
}
