import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/controller/pet_meds_controller.dart';
import 'package:petjournal/app/pet/models/pet_med_model.dart';
import 'package:petjournal/extensions/material_colors.dart';
import 'package:flutter/material.dart';
import 'package:petjournal/widgets/date_field.dart';
import 'package:go_router/go_router.dart';
import 'package:petjournal/route_config.dart';

class EditPetMedScreen extends ConsumerStatefulWidget {
  static final petMedNameKey = GlobalKey<FormFieldState>();
  static final petMedDoseKey = GlobalKey<FormFieldState>();
  static final petMedStartDateKey = GlobalKey<FormFieldState>();
  static final petMedEndDateKey = GlobalKey<FormFieldState>();
  static final petMedNotesKey = GlobalKey<FormFieldState>();
  static final petMedDeleteKey = GlobalKey<FormFieldState>();

  // If editing, this is the record we are editing.
  // If adding new this will be null
  final PetMedModel? petMed;
  final int petId;
  const EditPetMedScreen({super.key, required this.petId, this.petMed});

  @override
  ConsumerState<EditPetMedScreen> createState() => _EditPetMedScreenState();
}

class _EditPetMedScreenState extends ConsumerState<EditPetMedScreen> {
  bool _unsavedChanges = false;
  final _formKey = GlobalKey<FormState>();

  // --- Text Controllers ---
  late TextEditingController _nameController;
  late TextEditingController _doseController;
  late TextEditingController _notesController;

  // --- State Variables ---
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();

    // Initialize with existing pet data if available, otherwise defaults
    _nameController = TextEditingController(text: widget.petMed?.name);
    _doseController = TextEditingController(text: widget.petMed?.dose);
    _notesController = TextEditingController(text: widget.petMed?.notes ?? '');

    if (widget.petMed != null) {
      _startDate = widget.petMed!.startDate;
      _endDate = widget.petMed!.endDate;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _doseController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.petMed == null ? 'Add Medication' : 'Edit Medication',
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

                int? petMedId = await _saveData();
                if (petMedId == null) {
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
                    key: EditPetMedScreen.petMedNameKey,
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name*'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Name is required'
                        : null,
                    onChanged: (_) {
                      setState(() {
                        _unsavedChanges = true;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: EditPetMedScreen.petMedDoseKey,
                    controller: _doseController,
                    decoration: const InputDecoration(labelText: 'Dose*'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Dose is required'
                        : null,
                    onChanged: (_) {
                      setState(() {
                        _unsavedChanges = true;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  DateField(
                    key: EditPetMedScreen.petMedStartDateKey,
                    initialDate: _startDate,
                    labelText: 'Start Date*',
                    onDateSelected: (DateTime? value) {
                      _startDate = value ?? _startDate;
                      _unsavedChanges = true;
                    },
                    onValidate: (DateTime? value) {
                      if (value == null) {
                        return 'Please select a start date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  DateField(
                    key: EditPetMedScreen.petMedEndDateKey,
                    initialDate: _startDate,
                    labelText: 'End Date',
                    onDateSelected: (DateTime? value) {
                      _endDate = value;
                      _unsavedChanges = true;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: EditPetMedScreen.petMedNotesKey,
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: 'Notes (Optional)',
                    ),
                    maxLines: 3,
                    onChanged: (_) {
                      setState(() {
                        _unsavedChanges = true;
                      });
                    },
                  ),

                  const SizedBox(height: 30),

                  // only show the delete button if the record has been saved
                  if (widget.petMed != null) ...[
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        key: EditPetMedScreen.petMedDeleteKey,
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
    // Construct the PetMedModel object
    final PetMedModel medData = PetMedModel(
      petMedId: widget.petMed?.petMedId,
      petId: widget.petId,
      name: _nameController.text,
      dose: _doseController.text,
      startDate: _startDate,
      endDate: _endDate,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
    );

    final controller = ref.read(
      petMedsControllerProvider(widget.petId).notifier,
    );
    PetMedModel? p = await controller.save(medData);
    int? petMedId = p?.petMedId;
    return petMedId;
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
    if (widget.petMed != null && widget.petMed!.petMedId != null) {
      final bool? shouldDelete = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete This Medication Entry?'),
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
          petMedsControllerProvider(widget.petId).notifier,
        );
        await controller.deletePetMed(widget.petMed!.petMedId!);

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Medication entry was removed successfully!')),
        );

        context.go(RouteDefs.home);
      }
    }
  }
}
