import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjournal/extensions/material_colors.dart';
import 'package:flutter/material.dart';
import 'package:petjournal/constants/custom_styles.dart';
//import 'package:petjournal/widgets/date_field.dart';
import 'package:go_router/go_router.dart';
import 'package:petjournal/route_config.dart';
//import 'package:petjournal/app/pet/controllers/pet_controller.dart';
import 'package:petjournal/app/home/models/pet_model.dart';

class EditPetScreen extends ConsumerStatefulWidget {
  static const petNameKey = Key('name');
  static const petDeleteKey = Key('deleteButton');

  // If editing, this is the pet record we are editing.
  // If adding new this will be null
  final PetModel? pet;

  const EditPetScreen({super.key, this.pet});

  @override
  ConsumerState<EditPetScreen> createState() => _EditPetScreenState();
}

class _EditPetScreenState extends ConsumerState<EditPetScreen> {
  TextEditingController nameController = TextEditingController();
  String? _petNameValidationError;
  bool _unsavedChanges = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.pet != null) {
      nameController.text = widget.pet!.name;
    }
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
              if (await _validatePetName(nameController.text)) {
                if (_formKey.currentState!.validate()) {
                  int? petId = await _saveData();
                  if (petId == null) {
                    // an error occurred and we cannot save?
                    return;
                  }

                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                  context.go(RouteDefs.home);
                }
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
            canPop: !_unsavedChanges,
            onPopInvokedWithResult: (bool didPop, _) async {
              if (didPop) {
                return;
              }
              await _showSaveChangesDialog();
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    key: EditPetScreen.petNameKey,
                    autofocus: true,
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      errorText: _petNameValidationError,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter some text";
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        _petNameValidationError = null;
                      });
                      _unsavedChanges = true;
                    },
                  ),
                  const Text(
                    'This is a unique name you use to identify a pet.',
                    style: CustomStyles.infoTextStyle,
                  ),

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

  Future<bool> _validatePetName(String? petName) async {
    return true;
    // final controller = ref.read(petControllerProvider.notifier);
    // String? validationMsg;

    // if (petName != null && petName.isNotEmpty) {
    //   bool response = await controller.doesPetNameExist(
    //     widget.pet?.petId,
    //     petName,
    //   );

    //   if (response) {
    //     validationMsg = "This name is already in use";
    //   }
    // }

    // setState(() {
    //   _petNameValidationError = validationMsg;
    // });

    // return (validationMsg == null);
  }

  Future<int?> _saveData() async {
    // final controller = ref.read(petControllerProvider.notifier);
    // int? petId = widget.pet?.petId;

    // if (widget.pet == null) {
    //   PetModel? p =
    //       await controller.createPet(nameController.text, _maturityDate!);
    //   if (p != null) {
    //     petId = p.petId;
    //   }
    // } else {
    //   await controller.updatePet(
    //       petId!, nameController.text, _maturityDate!);
    // }

    // return petId;
    return 1;
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

  Future<void> _showDeleteDialog() async {
    // if (widget.pet != null && widget.pet!.petId != null) {
    //   final bool? shouldDelete = await showDialog<bool>(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text('Delete This Pet?'),
    //         content: const Text('Are you sure you want to delete this pet?'),
    //         actions: <Widget>[
    //           TextButton(
    //             child: const Text('Yes'),
    //             onPressed: () async {
    //               Navigator.pop(context, true);
    //             },
    //           ),
    //           TextButton(
    //             child: const Text('No'),
    //             onPressed: () {
    //               Navigator.pop(context, false);
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );

    //   if (shouldDelete ?? false) {
    //     final controller = ref.read(petControllerProvider.notifier);
    //     await controller.deletePet(widget.pet!.petId!);

    //     if (!mounted) return;
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Pet removed successfully!')),
    //     );

    //     context.go(RouteDefs.home);
    //   }
    // }
  }

  @override
  void dispose() {
    nameController.dispose();

    super.dispose();
  }
}
