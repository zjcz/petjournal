// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_meds_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$petMedsControllerHash() => r'947bfcaa34f4c19eddb2d829efced29895108539';

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

abstract class _$PetMedsController
    extends BuildlessAutoDisposeStreamNotifier<List<PetMedModel>?> {
  late final int petId;

  Stream<List<PetMedModel>?> build(int petId);
}

/// See also [PetMedsController].
@ProviderFor(PetMedsController)
const petMedsControllerProvider = PetMedsControllerFamily();

/// See also [PetMedsController].
class PetMedsControllerFamily extends Family<AsyncValue<List<PetMedModel>?>> {
  /// See also [PetMedsController].
  const PetMedsControllerFamily();

  /// See also [PetMedsController].
  PetMedsControllerProvider call(int petId) {
    return PetMedsControllerProvider(petId);
  }

  @override
  PetMedsControllerProvider getProviderOverride(
    covariant PetMedsControllerProvider provider,
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
  String? get name => r'petMedsControllerProvider';
}

/// See also [PetMedsController].
class PetMedsControllerProvider
    extends
        AutoDisposeStreamNotifierProviderImpl<
          PetMedsController,
          List<PetMedModel>?
        > {
  /// See also [PetMedsController].
  PetMedsControllerProvider(int petId)
    : this._internal(
        () => PetMedsController()..petId = petId,
        from: petMedsControllerProvider,
        name: r'petMedsControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$petMedsControllerHash,
        dependencies: PetMedsControllerFamily._dependencies,
        allTransitiveDependencies:
            PetMedsControllerFamily._allTransitiveDependencies,
        petId: petId,
      );

  PetMedsControllerProvider._internal(
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
  Stream<List<PetMedModel>?> runNotifierBuild(
    covariant PetMedsController notifier,
  ) {
    return notifier.build(petId);
  }

  @override
  Override overrideWith(PetMedsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PetMedsControllerProvider._internal(
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
    PetMedsController,
    List<PetMedModel>?
  >
  createElement() {
    return _PetMedsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PetMedsControllerProvider && other.petId == petId;
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
mixin PetMedsControllerRef
    on AutoDisposeStreamNotifierProviderRef<List<PetMedModel>?> {
  /// The parameter `petId` of this provider.
  int get petId;
}

class _PetMedsControllerProviderElement
    extends
        AutoDisposeStreamNotifierProviderElement<
          PetMedsController,
          List<PetMedModel>?
        >
    with PetMedsControllerRef {
  _PetMedsControllerProviderElement(super.provider);

  @override
  int get petId => (origin as PetMedsControllerProvider).petId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
