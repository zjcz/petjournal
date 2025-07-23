// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$journalControllerHash() => r'0bab1a9af44050285fe70fec1044a784b7650b39';

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

abstract class _$JournalController
    extends BuildlessAutoDisposeStreamNotifier<List<JournalModel>> {
  late final int petId;

  Stream<List<JournalModel>> build(int petId);
}

/// See also [JournalController].
@ProviderFor(JournalController)
const journalControllerProvider = JournalControllerFamily();

/// See also [JournalController].
class JournalControllerFamily extends Family<AsyncValue<List<JournalModel>>> {
  /// See also [JournalController].
  const JournalControllerFamily();

  /// See also [JournalController].
  JournalControllerProvider call(int petId) {
    return JournalControllerProvider(petId);
  }

  @override
  JournalControllerProvider getProviderOverride(
    covariant JournalControllerProvider provider,
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
  String? get name => r'journalControllerProvider';
}

/// See also [JournalController].
class JournalControllerProvider
    extends
        AutoDisposeStreamNotifierProviderImpl<
          JournalController,
          List<JournalModel>
        > {
  /// See also [JournalController].
  JournalControllerProvider(int petId)
    : this._internal(
        () => JournalController()..petId = petId,
        from: journalControllerProvider,
        name: r'journalControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$journalControllerHash,
        dependencies: JournalControllerFamily._dependencies,
        allTransitiveDependencies:
            JournalControllerFamily._allTransitiveDependencies,
        petId: petId,
      );

  JournalControllerProvider._internal(
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
  Stream<List<JournalModel>> runNotifierBuild(
    covariant JournalController notifier,
  ) {
    return notifier.build(petId);
  }

  @override
  Override overrideWith(JournalController Function() create) {
    return ProviderOverride(
      origin: this,
      override: JournalControllerProvider._internal(
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
    JournalController,
    List<JournalModel>
  >
  createElement() {
    return _JournalControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JournalControllerProvider && other.petId == petId;
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
mixin JournalControllerRef
    on AutoDisposeStreamNotifierProviderRef<List<JournalModel>> {
  /// The parameter `petId` of this provider.
  int get petId;
}

class _JournalControllerProviderElement
    extends
        AutoDisposeStreamNotifierProviderElement<
          JournalController,
          List<JournalModel>
        >
    with JournalControllerRef {
  _JournalControllerProviderElement(super.provider);

  @override
  int get petId => (origin as JournalControllerProvider).petId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
