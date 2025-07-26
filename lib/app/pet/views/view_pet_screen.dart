import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petjournal/app/pet/controller/pet_controller.dart';
import 'package:petjournal/app/pet/views/widgets/journal_widget.dart';
import 'package:petjournal/app/pet/views/widgets/pet_meds_widget.dart';
import 'package:petjournal/app/pet/views/widgets/pet_vaccinations_widget.dart';
import 'package:petjournal/app/pet/views/widgets/pet_weights_widget.dart';
import 'package:petjournal/app/pet/views/widgets/pet_widget.dart';
import 'package:flutter/material.dart';
import 'package:petjournal/app/pet/models/pet_model.dart';
import 'package:petjournal/constants/custom_styles.dart';
import 'package:petjournal/widgets/expandable_fab.dart';
import 'package:petjournal/widgets/loading_widget.dart';

import '../../../route_config.dart';

class ViewPetScreen extends ConsumerStatefulWidget {
  final int petId;

  const ViewPetScreen({super.key, required this.petId});

  @override
  ConsumerState<ViewPetScreen> createState() => _ViewPetScreenState();
}

class _ViewPetScreenState extends ConsumerState<ViewPetScreen> {
  @override
  Widget build(BuildContext context) {
    final pet = ref.watch(petControllerProvider(widget.petId));

    return pet.when(
      data: (pet) {
        if (pet == null) {
          return const Center(child: Text('Pet not found'));
        }
        return _buildPetDetails(pet);
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      loading: () => LoadingWidget(labelText: 'Loading Pet Details...'),
    );
  }

  Widget _buildPetDetails(PetModel pet) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(pet.name),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await context.push(RouteDefs.editPet, extra: pet);
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.info), text: 'General'),
              Tab(icon: Icon(Icons.medical_services), text: 'Health'),
              Tab(icon: Icon(Icons.balance), text: 'Weight'),
              Tab(icon: Icon(Icons.content_paste), text: 'Journal'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildGeneralInfoTab(pet),
            _buildPetMedsAndVaccinationInfoTab(pet),
            _buildPetWeightInfoTab(pet),
            _buildPetJournalTab(pet),
          ],
        ),
        floatingActionButton: ExpandableFab(
          distance: 112,
          children: [
            ActionButton(
              onPressed: () async {
                await context.push(
                  '${RouteDefs.editJournalEntry}/${pet.petId}',
                );
              },
              icon: const Icon(Icons.content_paste),
            ),
            ActionButton(
              onPressed: () async {
                await context.push('${RouteDefs.editPetWeight}/${pet.petId}');
              },
              icon: const Icon(Icons.balance),
            ),
            ActionButton(
              onPressed: () async {
                await context.push(
                  '${RouteDefs.editPetVaccination}/${pet.petId}',
                );
              },
              icon: const Icon(Icons.vaccines),
            ),
            ActionButton(
              onPressed: () async {
                await context.push('${RouteDefs.editPetMed}/${pet.petId}');
              },
              icon: const Icon(Icons.medication),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralInfoTab(PetModel pet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: PetWidget(pet: pet),
    );
  }

  Widget _buildPetMedsAndVaccinationInfoTab(PetModel pet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Text('Medical Information', style: CustomStyles.headerTextStyle),
            PetMedsWidget(petId: pet.petId!),
            Text('Vaccinations', style: CustomStyles.headerTextStyle),
            PetVaccinationsWidget(petId: pet.petId!),
          ],
        ),
      ),
    );
  }

  Widget _buildPetWeightInfoTab(PetModel pet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: PetWeightsWidget(petId: pet.petId!),
    );
  }

  Widget _buildPetJournalTab(PetModel pet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: JournalWidget(petId: pet.petId!),
    );
  }
}
