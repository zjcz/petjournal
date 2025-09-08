// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_vaccinations_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$petVaccinationsControllerHash() =>
    r'2c825a097b20177214475c0a898506c6db414701';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$PetVaccinationsController
    extends BuildlessAutoDisposeStreamNotifier<List<PetVaccinationModel>> {
  late final int petId;

  Stream<List<PetVaccinationModel>> build(int petId);
}

/// See also [PetVaccinationsController].
@ProviderFor(PetVaccinationsController)
const petVaccinationsControllerProvider = PetVaccinationsControllerFamily();

/// See also [PetVaccinationsController].
class PetVaccinationsControllerFamily
    extends Family<AsyncValue<List<PetVaccinationModel>>> {
  /// See also [PetVaccinationsController].
  const PetVaccinationsControllerFamily();

  /// See also [PetVaccinationsController].
  PetVaccinationsControllerProvider call(int petId) {
    return PetVaccinationsControllerProvider(petId);
  }

  @override
  PetVaccinationsControllerProvider getProviderOverride(
    covariant PetVaccinationsControllerProvider provider,
  ) {
    return call(provider.petId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'petVaccinationsControllerProvider';
}

/// See also [PetVaccinationsController].
class PetVaccinationsControllerProvider
    extends
        AutoDisposeStreamNotifierProviderImpl<
          PetVaccinationsController,
          List<PetVaccinationModel>
        > {
  /// See also [PetVaccinationsController].
  PetVaccinationsControllerProvider(int petId)
    : this._internal(
        () => PetVaccinationsController()..petId = petId,
        from: petVaccinationsControllerProvider,
        name: r'petVaccinationsControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$petVaccinationsControllerHash,
        dependencies: PetVaccinationsControllerFamily._dependencies,
        allTransitiveDependencies:
            PetVaccinationsControllerFamily._allTransitiveDependencies,
        petId: petId,
      );

  PetVaccinationsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.petId,
  }) : super.internal();

  final int petId;

  @override
  Stream<List<PetVaccinationModel>> runNotifierBuild(
    covariant PetVaccinationsController notifier,
  ) {
    return notifier.build(petId);
  }

  @override
  Override overrideWith(PetVaccinationsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PetVaccinationsControllerProvider._internal(
        () => create()..petId = petId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        petId: petId,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<
    PetVaccinationsController,
    List<PetVaccinationModel>
  >
  createElement() {
    return _PetVaccinationsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PetVaccinationsControllerProvider && other.petId == petId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, petId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PetVaccinationsControllerRef
    on AutoDisposeStreamNotifierProviderRef<List<PetVaccinationModel>> {
  /// The parameter `petId` of this provider.
  int get petId;
}

class _PetVaccinationsControllerProviderElement
    extends
        AutoDisposeStreamNotifierProviderElement<
          PetVaccinationsController,
          List<PetVaccinationModel>
        >
    with PetVaccinationsControllerRef {
  _PetVaccinationsControllerProviderElement(super.provider);

  @override
  int get petId => (origin as PetVaccinationsControllerProvider).petId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
