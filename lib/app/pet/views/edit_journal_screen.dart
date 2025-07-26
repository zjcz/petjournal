import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/controller/journal_controller.dart';
import 'package:petjournal/app/pet/models/journal_model.dart';
import 'package:petjournal/extensions/material_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petjournal/route_config.dart';

class EditJournalScreen extends ConsumerStatefulWidget {
  static final journalEntryTextKey = GlobalKey<FormFieldState>();
  static final journalTagsKey = GlobalKey<FormFieldState>();
  static final journalDeleteKey = GlobalKey<FormFieldState>();

  // If editing, this is the journal record we are editing.
  // If adding new this will be null
  final JournalModel? journalEntry;
  final int petId;
  const EditJournalScreen({super.key, required this.petId, this.journalEntry});

  @override
  ConsumerState<EditJournalScreen> createState() => _EditJournalScreennState();
}

class _EditJournalScreennState extends ConsumerState<EditJournalScreen> {
  bool _unsavedChanges = false;
  final _formKey = GlobalKey<FormState>();

  // --- Text Controllers ---
  late TextEditingController _entryTextController;
  late TextEditingController _tagsController;

  @override
  void initState() {
    super.initState();

    // Initialize with existing pet data if available, otherwise defaults
    _entryTextController = TextEditingController(
      text: widget.journalEntry?.entryText,
    );
    _tagsController = TextEditingController(
      text: widget.journalEntry?.tags.join(', '),
    );
  }

  @override
  void dispose() {
    _entryTextController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.journalEntry == null
              ? 'Add Journal Entry'
              : 'Edit Journal Entry',
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: context.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text(
              'Save',
              style: TextStyle(
                backgroundColor: context.primary,
                color: context.onPrimary,
              ),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                int? journalEntryId = await _saveData();
                if (journalEntryId == null) {
                  // an error occurred and we cannot save?
                  return;
                }

                if (!context.mounted) return;
                Navigator.of(context).pop();
                context.go('${RouteDefs.viewPet}/${widget.petId}');
              } else {
                final errorFields = _formKey.currentState!.validateGranularly();
                if (errorFields.isNotEmpty &&
                    errorFields.first.widget.key is GlobalKey<FormFieldState>) {
                  // Scroll to the first error field
                  await _scrollToField(
                    errorFields.first.widget.key as GlobalKey<FormFieldState>,
                  );
                }

                // Form is not valid, show a message or scroll to the first error
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please correct the errors in the form.'),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            canPop: !_unsavedChanges,
            onPopInvokedWithResult: (bool didPop, _) async {
              if (didPop) {
                return;
              }
              await _showSaveChangesDialog();
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    key: EditJournalScreen.journalEntryTextKey,
                    controller: _entryTextController,
                    decoration: const InputDecoration(
                      labelText: 'Journal Entry*',
                    ),
                    maxLines: 3,
                    validator: (value) => value == null || value.isEmpty
                        ? 'An entry is required'
                        : null,
                    onChanged: (_) {
                      setState(() {
                        _unsavedChanges = true;
                      });
                    },
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    key: EditJournalScreen.journalTagsKey,
                    controller: _tagsController,
                    decoration: const InputDecoration(
                      labelText: 'Tags (Optional)',
                    ),
                    onChanged: (_) {
                      setState(() {
                        _unsavedChanges = true;
                      });
                    },
                  ),

                  const SizedBox(height: 30),

                  // only show the delete button if the record has been saved
                  if (widget.journalEntry != null) ...[
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        key: EditJournalScreen.journalDeleteKey,
                        onPressed: () async {
                          await _showDeleteDialog();
                        },
                        style: TextButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<int?> _saveData() async {
    // Construct the Journal object
    final JournalModel journalData = JournalModel(
      journalEntryId: widget.journalEntry?.journalEntryId,
      entryText: _entryTextController.text,
      tags: _tagsController.text.isEmpty
          ? []
          : _tagsController.text
                .split(',')
                .map((e) => e.trim().toLowerCase())
                .toList(),
      petIdList: [widget.petId], // Currently only allowed against single pet
    );

    final controller = ref.read(
      journalControllerProvider(widget.petId).notifier,
    );
    JournalModel? j = await controller.save(journalData);
    int? journalEntryId = j?.journalEntryId;
    return journalEntryId;
  }

  Future<void> _showSaveChangesDialog() async {
    final bool? shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Any unsaved changes will be lost!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes, discard my changes'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: const Text('No, continue editing'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );

    if (shouldDiscard ?? false) {
      if (!mounted) return;
      context.pop();
    }
  }

  Future<void> _scrollToField(GlobalKey<FormFieldState> key) async {
    final context = key.currentContext;
    if (context == null) return;
    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      alignment: 0.1,
    );
  }

  Future<void> _showDeleteDialog() async {
    if (widget.journalEntry != null &&
        widget.journalEntry!.journalEntryId != null) {
      final bool? shouldDelete = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete This Journal Entry?'),
            content: const Text(
              'Are you sure you want to delete this record from the app?',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Yes'),
                onPressed: () async {
                  Navigator.pop(context, true);
                },
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () async {
                  Navigator.pop(context, false);
                },
              ),
            ],
          );
        },
      );

      if (shouldDelete ?? false) {
        final controller = ref.read(
          journalControllerProvider(widget.petId).notifier,
        );
        await controller.deleteJournalEntry(
          widget.journalEntry!.journalEntryId!,
        );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Journal entry was removed successfully!')),
        );

        context.go(RouteDefs.home);
      }
    }
  }
}
