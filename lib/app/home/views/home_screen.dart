import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:petjournal/app/pet/controller/all_pets_controller.dart';
import 'package:petjournal/app/pet/models/pet_model.dart';
import 'package:petjournal/data/database/database_service.dart';
import 'package:petjournal/route_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final petsData = ref.watch(allPetsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, semanticLabel: 'Add New Pet'),
            onPressed: () async {
              await context.push(RouteDefs.editPet);
            },
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, semanticLabel: 'More Options'),
            itemBuilder: (BuildContext bc) {
              return const [
                PopupMenuItem(value: 'settings', child: Text("Settings")),
                PopupMenuItem(value: 'about', child: Text("About...")),
                if (kDebugMode)
                  PopupMenuItem(
                    value: 'reset_test_data',
                    child: Text("Reset Test Data"),
                  ),
              ];
            },
            onSelected: (value) async {
              if (value == 'settings') {
                await context.push(RouteDefs.editSettings);
              } else if (value == 'about') {
                await context.push(RouteDefs.aboutScreen);
              } else if (value == 'reset_test_data' && kDebugMode) {
                await ref.read(DatabaseService.provider).populateTestData();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: petsData.when(
            data: (pets) {
              if (pets.isEmpty) {
                return const Center(
                  child: Text('No pets found.  Click + to add one'),
                );
              } else {
                return ListView.builder(
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    final pet = pets[index];
                    return buildPetListTile(pet);
                  },
                );
              }
            },
            loading: () => buildLoadingWidget(),
            error: (error, _) => buildErrorWidget(error),
          ),
        ),
      ),
    );
  }

  String getPetSubTitle(PetModel pet) {
    final data = [
      pet.species.name,
      pet.breed,
      pet.colour,
      if (pet.age != null) '${pet.age} years',
    ];

    return data.join(" | ");
  }

  Widget buildPetListTile(PetModel pet) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.pets, semanticLabel: 'Pet Icon', color: Colors.white),
      ),
      title: Text(pet.name),
      subtitle: Text(getPetSubTitle(pet)),
      onTap: () async {
        await context.push('${RouteDefs.viewPet}/${pet.petId}');
      },
    );
  }

  Widget buildLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget buildErrorWidget(Object error) {
    return Center(child: Text('Error loading data: $error'));
  }
}
