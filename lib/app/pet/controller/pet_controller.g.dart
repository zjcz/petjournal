// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$petControllerHash() => r'2ff405925e55841142607946d656f76a9bb2cb06';

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

abstract class _$PetController
    extends BuildlessAutoDisposeStreamNotifier<PetModel?> {
  late final int petId;

  Stream<PetModel?> build(int petId);
}

/// See also [PetController].
@ProviderFor(PetController)
const petControllerProvider = PetControllerFamily();

/// See also [PetController].
class PetControllerFamily extends Family<AsyncValue<PetModel?>> {
  /// See also [PetController].
  const PetControllerFamily();

  /// See also [PetController].
  PetControllerProvider call(int petId) {
    return PetControllerProvider(petId);
  }

  @override
  PetControllerProvider getProviderOverride(
    covariant PetControllerProvider provider,
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
  String? get name => r'petControllerProvider';
}

/// See also [PetController].
class PetControllerProvider
    extends AutoDisposeStreamNotifierProviderImpl<PetController, PetModel?> {
  /// See also [PetController].
  PetControllerProvider(int petId)
    : this._internal(
        () => PetController()..petId = petId,
        from: petControllerProvider,
        name: r'petControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$petControllerHash,
        dependencies: PetControllerFamily._dependencies,
        allTransitiveDependencies:
            PetControllerFamily._allTransitiveDependencies,
        petId: petId,
      );

  PetControllerProvider._internal(
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
  Stream<PetModel?> runNotifierBuild(covariant PetController notifier) {
    return notifier.build(petId);
  }

  @override
  Override overrideWith(PetController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PetControllerProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<PetController, PetModel?>
  createElement() {
    return _PetControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PetControllerProvider && other.petId == petId;
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
mixin PetControllerRef on AutoDisposeStreamNotifierProviderRef<PetModel?> {
  /// The parameter `petId` of this provider.
  int get petId;
}

class _PetControllerProviderElement
    extends AutoDisposeStreamNotifierProviderElement<PetController, PetModel?>
    with PetControllerRef {
  _PetControllerProviderElement(super.provider);

  @override
  int get petId => (origin as PetControllerProvider).petId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
