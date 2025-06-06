// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_microchips_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$petMicrochipsControllerHash() =>
    r'be2af57f460d45035a7bb20584d26591fe39262e';

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

abstract class _$PetMicrochipsController
    extends BuildlessAutoDisposeStreamNotifier<List<PetMicrochipModel>?> {
  late final int petId;

  Stream<List<PetMicrochipModel>?> build(int petId);
}

/// See also [PetMicrochipsController].
@ProviderFor(PetMicrochipsController)
const petMicrochipsControllerProvider = PetMicrochipsControllerFamily();

/// See also [PetMicrochipsController].
class PetMicrochipsControllerFamily
    extends Family<AsyncValue<List<PetMicrochipModel>?>> {
  /// See also [PetMicrochipsController].
  const PetMicrochipsControllerFamily();

  /// See also [PetMicrochipsController].
  PetMicrochipsControllerProvider call(int petId) {
    return PetMicrochipsControllerProvider(petId);
  }

  @override
  PetMicrochipsControllerProvider getProviderOverride(
    covariant PetMicrochipsControllerProvider provider,
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
  String? get name => r'petMicrochipsControllerProvider';
}

/// See also [PetMicrochipsController].
class PetMicrochipsControllerProvider
    extends
        AutoDisposeStreamNotifierProviderImpl<
          PetMicrochipsController,
          List<PetMicrochipModel>?
        > {
  /// See also [PetMicrochipsController].
  PetMicrochipsControllerProvider(int petId)
    : this._internal(
        () => PetMicrochipsController()..petId = petId,
        from: petMicrochipsControllerProvider,
        name: r'petMicrochipsControllerProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$petMicrochipsControllerHash,
        dependencies: PetMicrochipsControllerFamily._dependencies,
        allTransitiveDependencies:
            PetMicrochipsControllerFamily._allTransitiveDependencies,
        petId: petId,
      );

  PetMicrochipsControllerProvider._internal(
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
  Stream<List<PetMicrochipModel>?> runNotifierBuild(
    covariant PetMicrochipsController notifier,
  ) {
    return notifier.build(petId);
  }

  @override
  Override overrideWith(PetMicrochipsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PetMicrochipsControllerProvider._internal(
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
    PetMicrochipsController,
    List<PetMicrochipModel>?
  >
  createElement() {
    return _PetMicrochipsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PetMicrochipsControllerProvider && other.petId == petId;
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
mixin PetMicrochipsControllerRef
    on AutoDisposeStreamNotifierProviderRef<List<PetMicrochipModel>?> {
  /// The parameter `petId` of this provider.
  int get petId;
}

class _PetMicrochipsControllerProviderElement
    extends
        AutoDisposeStreamNotifierProviderElement<
          PetMicrochipsController,
          List<PetMicrochipModel>?
        >
    with PetMicrochipsControllerRef {
  _PetMicrochipsControllerProviderElement(super.provider);

  @override
  int get petId => (origin as PetMicrochipsControllerProvider).petId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
