import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/app/pet/controller/all_pets_controller.dart';
import 'package:petjournal/app/pet/views/widgets/pet_sex_dropdown.dart';
import 'package:petjournal/app/pet/views/widgets/pet_status_dropdown.dart';
import 'package:petjournal/app/species/views/widgets/species_dropdown.dart';
import 'package:petjournal/extensions/material_colors.dart';
import 'package:flutter/material.dart';
import 'package:petjournal/widgets/date_field.dart';
import 'package:go_router/go_router.dart';
import 'package:petjournal/route_config.dart';
import 'package:petjournal/app/pet/models/pet_model.dart';

import '../../../constants/pet_sex.dart';
import '../../../constants/pet_status.dart';
import '../../species/models/species_model.dart';

class EditPetScreen extends ConsumerStatefulWidget {
  static final petNameKey = GlobalKey<FormFieldState>();
  static final petSpeciesKey = GlobalKey<FormFieldState>();
  static final petBreedKey = GlobalKey<FormFieldState>();
  static final petColourKey = GlobalKey<FormFieldState>();
  static final petSexKey = GlobalKey<FormFieldState>();
  static final petDobKey = GlobalKey<FormFieldState>();
  static final petDobEstimateKey = GlobalKey<FormFieldState>();
  static final petDietKey = GlobalKey<FormFieldState>();
  static final petNotesKey = GlobalKey<FormFieldState>();
  static final petHistoryKey = GlobalKey<FormFieldState>();
  static final petNeuteredKey = GlobalKey<FormFieldState>();
  static final petNeuterDateKey = GlobalKey<FormFieldState>();
  static final petStatusKey = GlobalKey<FormFieldState>();
  static final petMicrochippedKey = GlobalKey<FormFieldState>();
  static final petMicrochipDateKey = GlobalKey<FormFieldState>();
  static final petMicrochipNumberKey = GlobalKey<FormFieldState>();
  static final petMicrochipCompanyKey = GlobalKey<FormFieldState>();
  static final petMicrochipNotesKey = GlobalKey<FormFieldState>();
  static final petDeleteKey = GlobalKey<FormFieldState>();

  // If editing, this is the pet record we are editing.
  // If adding new this will be null
  final PetModel? pet;

  const EditPetScreen({super.key, this.pet});

  @override
  ConsumerState<EditPetScreen> createState() => _EditPetScreenState();
}

class _EditPetScreenState extends ConsumerState<EditPetScreen> {
  bool _unsavedChanges = false;
  final _formKey = GlobalKey<FormState>();

  // --- Text Controllers ---
  late TextEditingController _nameController;
  late TextEditingController _breedController;
  late TextEditingController _colourController;
  late TextEditingController _dietController;
  late TextEditingController _notesController;
  late TextEditingController _historyController;
  late TextEditingController _microchipNotesController;
  late TextEditingController _microchipNumberController;
  late TextEditingController _microchipCompanyController;

  // --- State Variables ---
  PetSex _petSex = PetSex.unknown;
  DateTime? _dob;
  bool _dobEstimate = false;
  bool _isNeutered = false;
  DateTime? _neuterDate;
  PetStatus _status = PetStatus.active;
  SpeciesModel? _selectedSpecies; // Nullable until selected
  bool _isMicrochipped = false;
  DateTime? _microchipDate;

  @override
  void initState() {
    super.initState();

    // Initialize with existing pet data if available, otherwise defaults
    _nameController = TextEditingController(text: widget.pet?.name ?? '');
    _breedController = TextEditingController(text: widget.pet?.breed ?? '');
    _colourController = TextEditingController(text: widget.pet?.colour ?? '');
    _petSex = widget.pet?.petSex ?? PetSex.unknown;

    _dob = widget.pet?.dob;
    _dobEstimate = widget.pet?.dobEstimate ?? false;

    _dietController = TextEditingController(text: widget.pet?.diet ?? '');
    _notesController = TextEditingController(text: widget.pet?.notes ?? '');
    _historyController = TextEditingController(text: widget.pet?.history ?? '');

    _isNeutered = widget.pet?.isNeutered ?? false;
    _neuterDate = widget.pet?.neuterDate;

    _status = widget.pet?.status ?? PetStatus.active;

    _isMicrochipped = widget.pet?.isMicrochipped ?? false;
    _microchipDate = widget.pet?.microchipDate;
    _microchipNotesController = TextEditingController(
      text: widget.pet?.microchipNotes ?? '',
    );
    _microchipNumberController = TextEditingController(
      text: widget.pet?.microchipNumber ?? '',
    );
    _microchipCompanyController = TextEditingController(
      text: widget.pet?.microchipCompany ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _colourController.dispose();
    _dietController.dispose();
    _notesController.dispose();
    _historyController.dispose();
    _microchipNotesController.dispose();
    _microchipNumberController.dispose();
    _microchipCompanyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pet == null ? 'Add Pet' : 'Edit Pet'),
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

                int? petId = await _saveData();
                if (petId == null) {
                  // an error occurred and we cannot save?
                  return;
                }

                if (!context.mounted) return;
                Navigator.of(context).pop();
                context.go('${RouteDefs.viewPet}/$petId');
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
                  _buildSectionHeader('Basic Information'),
                  TextFormField(
                    key: EditPetScreen.petNameKey,
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
                  SpeciesDropdown(
                    key: EditPetScreen.petSpeciesKey,
                    species: _selectedSpecies,
                    labelText: 'Species*',
                    onChanged: (SpeciesModel? newValue) {
                      setState(() {
                        _selectedSpecies = newValue;
                        _unsavedChanges = true;
                      });
                    },
                    onValidate: (value) {
                      return value == null ? 'Species is required' : null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: EditPetScreen.petBreedKey,
                    controller: _breedController,
                    decoration: const InputDecoration(labelText: 'Breed*'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Breed is required'
                        : null,
                    onChanged: (_) {
                      setState(() {
                        _unsavedChanges = true;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: EditPetScreen.petColourKey,
                    controller: _colourController,
                    decoration: const InputDecoration(labelText: 'Colour*'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Colour is required'
                        : null,
                    onChanged: (_) {
                      setState(() {
                        _unsavedChanges = true;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  PetSexDropdown(
                    key: EditPetScreen.petSexKey,
                    labelText: 'Sex*',
                    selectedValue: _petSex,
                    onChanged: (PetSex? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _petSex = newValue;
                          _unsavedChanges = true;
                        });
                      }
                    },
                    onValidate: (value) =>
                        value == null ? 'Sex is required' : null,
                  ),
                  DateField(
                    key: EditPetScreen.petDobKey,
                    initialDate: _dob,
                    labelText: 'Date of Birth',
                    onDateSelected: (DateTime? value) {
                      _dob = value;
                      _unsavedChanges = true;
                    },
                    // DOB can be optional, so no validator unless specific rules apply
                  ),
                  FormField<bool>(
                    key: EditPetScreen.petDobEstimateKey,
                    builder: (state) {
                      return CheckboxListTile(
                        title: Text('Date of Birth is an estimate?'),
                        value: _dobEstimate,
                        onChanged: (bool? value) {
                          setState(() {
                            _dobEstimate = value ?? false;
                            _unsavedChanges = true;
                            state.didChange(value);
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      );
                    },
                    initialValue: _dobEstimate,
                  ),
                  PetStatusDropdown(
                    key: EditPetScreen.petStatusKey,
                    labelText: 'Current Status*',
                    selectedValue: _status,
                    onChanged: (PetStatus? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _status = newValue;
                          _unsavedChanges = true;
                        });
                      }
                    },
                    onValidate: (value) {
                      return value == null ? 'Status is required' : null;
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildSectionHeader('Health & Care'),
                  FormField<bool>(
                    key: EditPetScreen.petNeuteredKey,
                    builder: (state) {
                      return CheckboxListTile(
                        title: Text('Is Neutered/Spayed?'),
                        value: _isNeutered,
                        onChanged: (bool? value) {
                          setState(() {
                            _isNeutered = value ?? false;
                            _unsavedChanges = true;
                            if (!_isNeutered) {
                              // Clear date if not neutered
                              _neuterDate = null;
                            }
                            state.didChange(value);
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      );
                    },
                    initialValue: _isNeutered,
                  ),
                  if (_isNeutered) // Only show neuter date field if neutered
                    DateField(
                      key: EditPetScreen.petNeuterDateKey,
                      initialDate: _neuterDate,
                      labelText: 'Neuter/Spay Date*',
                      onDateSelected: (DateTime? value) {
                        _neuterDate = value;
                        _unsavedChanges = true;
                      },
                      onValidate: (DateTime? value) {
                        if (_isNeutered && (value == null)) {
                          return 'Neuter date is required if pet is neutered';
                        }
                        return null;
                      },
                    ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: EditPetScreen.petDietKey,
                    controller: _dietController,
                    decoration: const InputDecoration(
                      labelText: 'Diet (Optional)',
                    ),
                    maxLines: 2,
                    onChanged: (_) {
                      setState(() {
                        _unsavedChanges = true;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildSectionHeader('Microchip Information'),
                  FormField<bool>(
                    key: EditPetScreen.petMicrochippedKey,
                    builder: (state) {
                      return CheckboxListTile(
                        title: Text('Is Microchipped?'),
                        value: _isMicrochipped,
                        onChanged: (bool? value) {
                          setState(() {
                            _isMicrochipped = value ?? false;
                            if (!_isMicrochipped) {
                              // Clear microchip fields if not microchipped
                              _microchipDate = null;
                              _microchipNumberController.text = '';
                              _microchipCompanyController.text = '';
                              _microchipNotesController.text = '';
                            }
                            _unsavedChanges = true;
                            state.didChange(value);
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      );
                    },
                    initialValue: _isMicrochipped,
                  ),
                  if (_isMicrochipped) ...[
                    // Show these fields only if microchipped
                    TextFormField(
                      key: EditPetScreen.petMicrochipNumberKey,
                      controller: _microchipNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Microchip Number*',
                      ),
                      validator: (value) {
                        // Example: Make required if microchipped
                        if (_isMicrochipped &&
                            (value == null || value.isEmpty)) {
                          return 'Microchip number is required if pet is microchipped';
                        }
                        return null;
                      },
                      onChanged: (_) {
                        setState(() {
                          _unsavedChanges = true;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      key: EditPetScreen.petMicrochipCompanyKey,
                      controller: _microchipCompanyController,
                      decoration: const InputDecoration(
                        labelText: 'Microchip Company (Optional)',
                      ),
                      onChanged: (_) {
                        setState(() {
                          _unsavedChanges = true;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    DateField(
                      key: EditPetScreen.petMicrochipDateKey,
                      initialDate: _microchipDate,
                      labelText: 'Microchip Date',
                      onDateSelected: (DateTime? value) {
                        _microchipDate = value;
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
                      key: EditPetScreen.petMicrochipNotesKey,
                      controller: _microchipNotesController,
                      decoration: const InputDecoration(
                        labelText: 'Microchip Notes (Optional)',
                      ),
                      maxLines: 2,
                      onChanged: (_) {
                        setState(() {
                          _unsavedChanges = true;
                        });
                      },
                    ),
                  ],
                  const SizedBox(height: 12),
                  _buildSectionHeader('Additional Notes'),
                  TextFormField(
                    key: EditPetScreen.petNotesKey,
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: 'General Notes (Optional)',
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
                    key: EditPetScreen.petHistoryKey,
                    controller: _historyController,
                    decoration: const InputDecoration(
                      labelText: 'History (Optional)',
                    ),
                    maxLines: 3,
                    onChanged: (_) {
                      setState(() {
                        _unsavedChanges = true;
                      });
                    },
                  ),

                  const SizedBox(height: 30),

                  // only show the delete button if the pet has been saved
                  if (widget.pet != null) ...[
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        key: EditPetScreen.petDeleteKey,
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
    // Construct the Pet object
    final PetModel petData = PetModel(
      petId: widget.pet?.petId,
      name: _nameController.text,
      breed: _breedController.text,
      colour: _colourController.text,
      petSex: _petSex,
      dob: _dob,
      dobEstimate: _dobEstimate,
      diet: _dietController.text.isEmpty ? null : _dietController.text,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
      history: _historyController.text.isEmpty ? null : _historyController.text,
      isNeutered: _isNeutered,
      neuterDate: _isNeutered ? _neuterDate : null,
      // Only save neuter date if neutered
      status: _status,
      statusDate: widget.pet == null || widget.pet!.status != _status
          ? DateTime.now()
          : widget.pet!.statusDate,
      species: _selectedSpecies!,
      // Assume _selectedSpecies will be validated to not be null
      isMicrochipped: _isMicrochipped,
      microchipDate: _isMicrochipped ? _microchipDate : null,
      // Only save microchip date if microchipped
      microchipNotes:
          _isMicrochipped && _microchipNotesController.text.isNotEmpty
          ? _microchipNotesController.text
          : null,
      microchipNumber:
          _isMicrochipped && _microchipNumberController.text.isNotEmpty
          ? _microchipNumberController.text
          : null,
      microchipCompany:
          _isMicrochipped && _microchipCompanyController.text.isNotEmpty
          ? _microchipCompanyController.text
          : null,
    );

    final controller = ref.read(allPetsControllerProvider.notifier);
    PetModel? p = await controller.save(petData);
    int? petId = p?.petId;
    return petId;
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
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
    if (widget.pet != null && widget.pet!.petId != null) {
      final bool? shouldDelete = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete This Pet?'),
            content: const Text(
              'Are you sure you want to delete this pet from the app?',
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
        String petName = widget.pet!.name;
        final controller = ref.read(allPetsControllerProvider.notifier);
        await controller.deletePet(widget.pet!.petId!);

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$petName was removed successfully!')),
        );

        context.go(RouteDefs.home);
      }
    }
  }
}
