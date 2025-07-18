import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/controller/pet_vaccinations_controller.dart';
import 'package:petjournal/app/pet/models/pet_vaccination_model.dart';
import 'package:petjournal/extensions/material_colors.dart';
import 'package:flutter/material.dart';
import 'package:petjournal/widgets/date_field.dart';
import 'package:go_router/go_router.dart';
import 'package:petjournal/route_config.dart';

class EditPetVaccinationScreen extends ConsumerStatefulWidget {
  static final petVacNameKey = GlobalKey<FormFieldState>();
  static final petVacKey = GlobalKey<FormFieldState>();
  static final petVacAdministeredDateKey = GlobalKey<FormFieldState>();
  static final petVacExpiryDateKey = GlobalKey<FormFieldState>();
  static final petVacReminderDateKey = GlobalKey<FormFieldState>();
  static final petVacNotesKey = GlobalKey<FormFieldState>();
  static final petVacBatchNumberKey = GlobalKey<FormFieldState>();
  static final petVacManufacturerKey = GlobalKey<FormFieldState>();
  static final petVacAdministeredByKey = GlobalKey<FormFieldState>();
  static final petVacDeleteKey = GlobalKey<FormFieldState>();

  // If editing, this is the record we are editing.
  // If adding new this will be null
  final PetVaccinationModel? petVaccination;
  final int petId;
  const EditPetVaccinationScreen({
    super.key,
    required this.petId,
    this.petVaccination,
  });

  @override
  ConsumerState<EditPetVaccinationScreen> createState() =>
      _EditPetVaccinationScreenState();
}

class _EditPetVaccinationScreenState
    extends ConsumerState<EditPetVaccinationScreen> {
  bool _unsavedChanges = false;
  final _formKey = GlobalKey<FormState>();

  // --- Text Controllers ---
  late TextEditingController _nameController;
  late TextEditingController _notesController;
  late TextEditingController _vaccineBatchNumber;
  late TextEditingController _vaccineManufacturer;
  late TextEditingController _administeredBy;

  // --- State Variables ---
  DateTime _administeredDate = DateTime.now();
  DateTime? _expiryDate;
  DateTime? _reminderDate;

  @override
  void initState() {
    super.initState();

    // Initialize with existing pet data if available, otherwise defaults
    _nameController = TextEditingController(
      text: widget.petVaccination?.name ?? '',
    );
    _notesController = TextEditingController(
      text: widget.petVaccination?.notes ?? '',
    );
    _vaccineBatchNumber = TextEditingController(
      text: widget.petVaccination?.vaccineBatchNumber ?? '',
    );
    _vaccineManufacturer = TextEditingController(
      text: widget.petVaccination?.vaccineManufacturer ?? '',
    );
    _administeredBy = TextEditingController(
      text: widget.petVaccination?.administeredBy ?? '',
    );

    if (widget.petVaccination != null) {
      _administeredDate = widget.petVaccination!.administeredDate;
      _expiryDate = widget.petVaccination!.expiryDate;
      _reminderDate = widget.petVaccination!.reminderDate;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    _vaccineBatchNumber.dispose();
    _vaccineManufacturer.dispose();
    _administeredBy.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.petVaccination == null
              ? 'Add Vaccination'
              : 'Edit Vaccination',
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

                int? petVaccinationId = await _saveData();
                if (petVaccinationId == null) {
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
                    key: EditPetVaccinationScreen.petVacNameKey,
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
                  DateField(
                    key: EditPetVaccinationScreen.petVacAdministeredDateKey,
                    initialDate: _administeredDate,
                    labelText: 'Administered Date*',
                    onDateSelected: (DateTime? value) {
                      _administeredDate = value ?? _administeredDate;
                      _unsavedChanges = true;
                    },
                    onValidate: (DateTime? value) {
                      if (value == null) {
                        return 'Please select an administered date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  DateField(
                    key: EditPetVaccinationScreen.petVacExpiryDateKey,
                    initialDate: _expiryDate,
                    labelText: 'Expiry Date',
                    onDateSelected: (DateTime? value) {
                      _expiryDate = value;
                      _unsavedChanges = true;
                    },
                  ),
                  const SizedBox(height: 12),
                  DateField(
                    key: EditPetVaccinationScreen.petVacReminderDateKey,
                    initialDate: _expiryDate,
                    labelText: 'Reminder Date',
                    onDateSelected: (DateTime? value) {
                      _expiryDate = value;
                      _unsavedChanges = true;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: EditPetVaccinationScreen.petVacNotesKey,
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
                  const SizedBox(height: 12),
                  TextFormField(
                    key: EditPetVaccinationScreen.petVacBatchNumberKey,
                    controller: _vaccineBatchNumber,
                    decoration: const InputDecoration(
                      labelText: 'Batch Number (Optional)',
                    ),
                    onChanged: (_) {
                      setState(() {
                        _unsavedChanges = true;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: EditPetVaccinationScreen.petVacManufacturerKey,
                    controller: _vaccineManufacturer,
                    decoration: const InputDecoration(
                      labelText: 'Manufacturer (Optional)',
                    ),
                    onChanged: (_) {
                      setState(() {
                        _unsavedChanges = true;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: EditPetVaccinationScreen.petVacAdministeredByKey,
                    controller: _administeredBy,
                    decoration: const InputDecoration(
                      labelText: 'Administered By (Optional)',
                    ),
                    onChanged: (_) {
                      setState(() {
                        _unsavedChanges = true;
                      });
                    },
                  ),

                  const SizedBox(height: 30),

                  // only show the delete button if the record has been saved
                  if (widget.petVaccination != null) ...[
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        key: EditPetVaccinationScreen.petVacDeleteKey,
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
    // Construct the PetVaccinationModel object
    final PetVaccinationModel vaccinationData = PetVaccinationModel(
      petVaccinationId: widget.petVaccination?.petVaccinationId,
      petId: widget.petId,
      name: _nameController.text,
      administeredDate: _administeredDate,
      expiryDate: _expiryDate,
      reminderDate: _reminderDate,
      vaccineBatchNumber: _vaccineBatchNumber.text,
      vaccineManufacturer: _vaccineManufacturer.text,
      administeredBy: _administeredBy.text,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
    );

    final controller = ref.read(
      petVaccinationsControllerProvider(widget.petId).notifier,
    );
    PetVaccinationModel? p = await controller.save(vaccinationData);
    int? petVaccinationId = p?.petVaccinationId;
    return petVaccinationId;
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
    if (widget.petVaccination != null &&
        widget.petVaccination!.petVaccinationId != null) {
      final bool? shouldDelete = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete This Vaccination Entry?'),
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
          petVaccinationsControllerProvider(widget.petId).notifier,
        );
        await controller.deletePetVaccination(
          widget.petVaccination!.petVaccinationId!,
        );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Vaccination entry was removed successfully!'),
          ),
        );

        context.go(RouteDefs.home);
      }
    }
  }
}
