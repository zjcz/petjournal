import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/controller/pet_weights_controller.dart';
import 'package:petjournal/app/pet/models/pet_weight_model.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/extensions/material_colors.dart';
import 'package:flutter/material.dart';
import 'package:petjournal/widgets/date_field.dart';
import 'package:go_router/go_router.dart';
import 'package:petjournal/route_config.dart';
import 'package:petjournal/widgets/weight_units_dropdown.dart';

class EditPetWeightScreen extends ConsumerStatefulWidget {
  static final petWeightWeightKey = GlobalKey<FormFieldState>();
  static final petWeightDateKey = GlobalKey<FormFieldState>();
  static final petWeightUnitKey = GlobalKey<FormFieldState>();
  static final petWeightNotesKey = GlobalKey<FormFieldState>();
  static final petWeightDeleteKey = GlobalKey<FormFieldState>();

  // If editing, this is the pet weight record we are editing.
  // If adding new this will be null
  final PetWeightModel? petWeight;
  final int petId;
  const EditPetWeightScreen({super.key, required this.petId, this.petWeight});

  @override
  ConsumerState<EditPetWeightScreen> createState() =>
      _EditPetWeightScreenState();
}

class _EditPetWeightScreenState extends ConsumerState<EditPetWeightScreen> {
  bool _unsavedChanges = false;
  final _formKey = GlobalKey<FormState>();

  // --- Text Controllers ---
  late TextEditingController _weightController;
  late TextEditingController _notesController;

  // --- State Variables ---
  DateTime _entryDate = DateTime.now();
  WeightUnits _weightUnits =
      WeightUnits.metric; //TODO load default from settings

  @override
  void initState() {
    super.initState();

    // Initialize with existing pet data if available, otherwise defaults
    _weightController = TextEditingController(
      text: widget.petWeight?.weight.toString(),
    );
    _notesController = TextEditingController(
      text: widget.petWeight?.notes ?? '',
    );

    if (widget.petWeight != null) {
      _entryDate = widget.petWeight!.date;
      _weightUnits = widget.petWeight!.weightUnit;
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.petWeight == null ? 'Add Weight' : 'Edit Weight'),
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

                int? petWeightId = await _saveData();
                if (petWeightId == null) {
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
                    key: EditPetWeightScreen.petWeightWeightKey,
                    controller: _weightController,
                    decoration: const InputDecoration(labelText: 'Weight*'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Weight is required'
                        : null,
                    onChanged: (_) {
                      setState(() {
                        _unsavedChanges = true;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  WeightUnitsDropdown(
                    key: EditPetWeightScreen.petWeightUnitKey,
                    value: _weightUnits,
                    labelText: 'Weight Unit*',
                    onChanged: (WeightUnits? newValue) {
                      setState(() {
                        _weightUnits = newValue ?? _weightUnits;
                        _unsavedChanges = true;
                      });
                    },
                  ),
                  DateField(
                    key: EditPetWeightScreen.petWeightDateKey,
                    initialDate: _entryDate,
                    labelText: 'Date',
                    onDateSelected: (DateTime? value) {
                      _entryDate = value ?? _entryDate;
                      _unsavedChanges = true;
                    },
                    onValidate: (DateTime? value) {
                      if (value == null) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: EditPetWeightScreen.petWeightNotesKey,
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
                  if (widget.petWeight != null) ...[
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        key: EditPetWeightScreen.petWeightDeleteKey,
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
    // Construct the PetWeight object
    final PetWeightModel weightData = PetWeightModel(
      petWeightId: widget.petWeight?.petWeightId,
      petId: widget.petId,
      weight: double.tryParse(_weightController.text) ?? 0.0,
      weightUnit: _weightUnits,
      date: _entryDate,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
    );

    final controller = ref.read(
      petWeightsControllerProvider(widget.petId).notifier,
    );
    PetWeightModel? p = await controller.save(weightData);
    int? petWeightId = p?.petWeightId;
    return petWeightId;
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
    if (widget.petWeight != null && widget.petWeight!.petWeightId != null) {
      final bool? shouldDelete = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete This Weight Entry?'),
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
          petWeightsControllerProvider(widget.petId).notifier,
        );
        await controller.deletePetWeight(widget.petWeight!.petWeightId!);

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Weight entry was removed successfully!')),
        );

        context.go(RouteDefs.home);
      }
    }
  }
}
