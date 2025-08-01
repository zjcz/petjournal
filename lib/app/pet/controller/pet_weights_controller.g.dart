// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_weights_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$petWeightsControllerHash() =>
    r'b36779f35a214f3d6ec4d51b683fb11bc177d7b2';

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

abstract class _$PetWeightsController
    extends BuildlessAutoDisposeStreamNotifier<List<PetWeightModel>> {
  late final int petId;

  Stream<List<PetWeightModel>> build(int petId);
}

/// See also [PetWeightsController].
@ProviderFor(PetWeightsController)
const petWeightsControllerProvider = PetWeightsControllerFamily();

/// See also [PetWeightsController].
class PetWeightsControllerFamily
    extends Family<AsyncValue<List<PetWeightModel>>> {
  /// See also [PetWeightsController].
  const PetWeightsControllerFamily();

  /// See also [PetWeightsController].
  PetWeightsControllerProvider call(int petId) {
    return PetWeightsControllerProvider(petId);
  }

  @override
  PetWeightsControllerProvider getProviderOverride(
    covariant PetWeightsControllerProvider provider,
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
  String? get name => r'petWeightsControllerProvider';
}

/// See also [PetWeightsController].
class PetWeightsControllerProvider
    extends
        AutoDisposeStreamNotifierProviderImpl<
          PetWeightsController,
          List<PetWeightModel>
        > {
  /// See also [PetWeightsController].
  PetWeightsControllerProvider(int petId)
    : this._internal(
        () => PetWeightsController()..petId = petId,
        from: petWeightsControllerProvider,
        name: r'petWeightsControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$petWeightsControllerHash,
        dependencies: PetWeightsControllerFamily._dependencies,
        allTransitiveDependencies:
            PetWeightsControllerFamily._allTransitiveDependencies,
        petId: petId,
      );

  PetWeightsControllerProvider._internal(
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
  Stream<List<PetWeightModel>> runNotifierBuild(
    covariant PetWeightsController notifier,
  ) {
    return notifier.build(petId);
  }

  @override
  Override overrideWith(PetWeightsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PetWeightsControllerProvider._internal(
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
    PetWeightsController,
    List<PetWeightModel>
  >
  createElement() {
    return _PetWeightsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PetWeightsControllerProvider && other.petId == petId;
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
mixin PetWeightsControllerRef
    on AutoDisposeStreamNotifierProviderRef<List<PetWeightModel>> {
  /// The parameter `petId` of this provider.
  int get petId;
}

class _PetWeightsControllerProviderElement
    extends
        AutoDisposeStreamNotifierProviderElement<
          PetWeightsController,
          List<PetWeightModel>
        >
    with PetWeightsControllerRef {
  _PetWeightsControllerProviderElement(super.provider);

  @override
  int get petId => (origin as PetWeightsControllerProvider).petId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
