// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_vaccinations_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$petVaccinationControllerHash() =>
    r'1940c8014ad0e5291aed7f3db5ec7da5c176be43';

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

abstract class _$PetVaccinationController
    extends BuildlessAutoDisposeStreamNotifier<List<PetVaccinationModel>> {
  late final int petId;

  Stream<List<PetVaccinationModel>> build(int petId);
}

/// See also [PetVaccinationController].
@ProviderFor(PetVaccinationController)
const petVaccinationControllerProvider = PetVaccinationControllerFamily();

/// See also [PetVaccinationController].
class PetVaccinationControllerFamily
    extends Family<AsyncValue<List<PetVaccinationModel>>> {
  /// See also [PetVaccinationController].
  const PetVaccinationControllerFamily();

  /// See also [PetVaccinationController].
  PetVaccinationControllerProvider call(int petId) {
    return PetVaccinationControllerProvider(petId);
  }

  @override
  PetVaccinationControllerProvider getProviderOverride(
    covariant PetVaccinationControllerProvider provider,
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
  String? get name => r'petVaccinationControllerProvider';
}

/// See also [PetVaccinationController].
class PetVaccinationControllerProvider
    extends
        AutoDisposeStreamNotifierProviderImpl<
          PetVaccinationController,
          List<PetVaccinationModel>
        > {
  /// See also [PetVaccinationController].
  PetVaccinationControllerProvider(int petId)
    : this._internal(
        () => PetVaccinationController()..petId = petId,
        from: petVaccinationControllerProvider,
        name: r'petVaccinationControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$petVaccinationControllerHash,
        dependencies: PetVaccinationControllerFamily._dependencies,
        allTransitiveDependencies:
            PetVaccinationControllerFamily._allTransitiveDependencies,
        petId: petId,
      );

  PetVaccinationControllerProvider._internal(
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
    covariant PetVaccinationController notifier,
  ) {
    return notifier.build(petId);
  }

  @override
  Override overrideWith(PetVaccinationController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PetVaccinationControllerProvider._internal(
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
    PetVaccinationController,
    List<PetVaccinationModel>
  >
  createElement() {
    return _PetVaccinationControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PetVaccinationControllerProvider && other.petId == petId;
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
mixin PetVaccinationControllerRef
    on AutoDisposeStreamNotifierProviderRef<List<PetVaccinationModel>> {
  /// The parameter `petId` of this provider.
  int get petId;
}

class _PetVaccinationControllerProviderElement
    extends
        AutoDisposeStreamNotifierProviderElement<
          PetVaccinationController,
          List<PetVaccinationModel>
        >
    with PetVaccinationControllerRef {
  _PetVaccinationControllerProviderElement(super.provider);

  @override
  int get petId => (origin as PetVaccinationControllerProvider).petId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
