import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:petjournal/app/pet/views/widgets/pet_weight_entry_widget.dart';
import 'package:petjournal/constants/weight_units.dart';
import 'package:petjournal/data/database/database_service.dart';

import 'pet_weight_entry_widget_test.mocks.dart';

@GenerateMocks([DatabaseService])
void main() {
  late MockDatabaseService mockDb;
  final formKey = GlobalKey<FormState>();
  const widgetKey = Key('testKey');
  final widgetKeyLbField = Key('${widgetKey}_lb');
  final widgetKeyOzField = Key('${widgetKey}_oz');

  Widget createWidget(
    MockDatabaseService db,
    String? labelText,
    String? errorText,
    double? weightKg,
    Function(double?) onChanged,
    String? Function(double?) onValidate,
  ) {
    return MaterialApp(
      home: ProviderScope(
        overrides: [DatabaseService.provider.overrideWithValue(db)],
        child: Scaffold(
          body: Form(
            key: formKey,
            child: PetWeightEntryWidget(
              key: widgetKey,
              weightKg: weightKg,
              labelText: labelText,
              errorText: errorText,
              onChanged: onChanged,
              onValidate: onValidate,
            ),
          ),
        ),
      ),
    );
  }

  Setting createMockSettings({WeightUnits weightUnit = WeightUnits.metric}) {
    return Setting(
      settingsId: 1,
      acceptedTermsAndConditions: true,
      onBoardingComplete: true,
      optIntoAnalyticsWarning: false,
      lastUsedVersion: null,
      defaultWeightUnit: weightUnit,
      createLinkedJournalEntries: true,
    );
  }

  setUp(() {
    mockDb = MockDatabaseService();
  });

  group('PetWeightEntryWidget Rendering', () {
    testWidgets('renders correctly for metric', (WidgetTester tester) async {
      // Arrange
      when(mockDb.watchSettings()).thenAnswer(
        (_) => Stream.value(createMockSettings(weightUnit: WeightUnits.metric)),
      );

      // Act
      await tester.pumpWidget(
        createWidget(
          mockDb,
          'Weight',
          'Weight is required',
          123,
          (_) {},
          (_) => null,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Weight'), findsOneWidget);
      expect(find.text('kg'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(1));
    });

    testWidgets('renders correctly for imperial', (WidgetTester tester) async {
      // Arrange
      when(mockDb.watchSettings()).thenAnswer(
        (_) =>
            Stream.value(createMockSettings(weightUnit: WeightUnits.imperial)),
      );

      // Act
      await tester.pumpWidget(
        createWidget(
          mockDb,
          'Weight',
          'Weight is required',
          123,
          (_) {},
          (_) => null,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Weight'), findsOneWidget);
      expect(find.text('kg'), findsNothing);
      expect(find.text('lb'), findsOneWidget);
      expect(find.text('oz'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
    });
  });

  group('PetWeightEntryWidget OnChange', () {
    testWidgets('onChange is triggered with new value for metric', (
      WidgetTester tester,
    ) async {
      double? newWeight;
      double newWeightEntered = 456;
      bool onChangeCalled = false;
      // Arrange
      when(mockDb.watchSettings()).thenAnswer(
        (_) => Stream.value(createMockSettings(weightUnit: WeightUnits.metric)),
      );

      // Act
      await tester.pumpWidget(
        createWidget(mockDb, 'Weight', 'Weight is required', 0, (newVal) {
          newWeight = newVal;
          onChangeCalled = true;
        }, (_) => null),
      );
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(widgetKey),
        newWeightEntered.toString(),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(newWeight, newWeightEntered);
      expect(onChangeCalled, isTrue);
    });

    testWidgets('onChange is triggered with new value for imperial lb', (
      WidgetTester tester,
    ) async {
      double? newWeight;
      int newWeightEntered = 2; // 2 lb = 0.907 kg
      bool onChangeCalled = false;
      // Arrange
      when(mockDb.watchSettings()).thenAnswer(
        (_) =>
            Stream.value(createMockSettings(weightUnit: WeightUnits.imperial)),
      );

      // Act
      await tester.pumpWidget(
        createWidget(mockDb, 'Weight', 'Weight is required', 0, (newVal) {
          newWeight = newVal;
          onChangeCalled = true;
        }, (_) => null),
      );
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(widgetKeyLbField),
        newWeightEntered.toString(),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(newWeight?.toStringAsFixed(3), '0.907');
      expect(onChangeCalled, isTrue);
    });

    testWidgets('onChange is triggered with new value doe imperial oz', (
      WidgetTester tester,
    ) async {
      double? newWeight;
      double newWeightEntered = 35.274; // 35.274 oz = 1 kg
      bool onChangeCalled = false;
      // Arrange
      when(mockDb.watchSettings()).thenAnswer(
        (_) =>
            Stream.value(createMockSettings(weightUnit: WeightUnits.imperial)),
      );

      // Act
      await tester.pumpWidget(
        createWidget(mockDb, 'Weight', 'Weight is required', 0, (newVal) {
          newWeight = newVal;
          onChangeCalled = true;
        }, (_) => null),
      );
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(widgetKeyOzField),
        newWeightEntered.toString(),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(newWeight?.toStringAsFixed(3), '1.000');
      expect(onChangeCalled, isTrue);
    });
  });

  group('PetWeightEntryWidget Validation', () {
    testWidgets('when empty metric value is entered then validation fails', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockDb.watchSettings()).thenAnswer(
        (_) => Stream.value(createMockSettings(weightUnit: WeightUnits.metric)),
      );

      // Act
      await tester.pumpWidget(
        createWidget(
          mockDb,
          'Weight',
          'Weight is required',
          0,
          (_) {},
          (_) => null,
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(widgetKey), '');
      await tester.pumpAndSettle();
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Weight is required'), findsOneWidget);
    });

    testWidgets('when empty lb value is entered then validation fails', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockDb.watchSettings()).thenAnswer(
        (_) =>
            Stream.value(createMockSettings(weightUnit: WeightUnits.imperial)),
      );

      // Act
      await tester.pumpWidget(
        createWidget(
          mockDb,
          'Weight',
          'Weight is required',
          0,
          (newVal) {},
          (_) => null,
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(widgetKeyLbField), '');
      await tester.pumpAndSettle();
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Weight is required'), findsOneWidget);
    });

    testWidgets('when empty oz value is entered then validation fails', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockDb.watchSettings()).thenAnswer(
        (_) =>
            Stream.value(createMockSettings(weightUnit: WeightUnits.imperial)),
      );

      // Act
      await tester.pumpWidget(
        createWidget(
          mockDb,
          'Weight',
          'Weight is required',
          0,
          (_) {},
          (_) => null,
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(widgetKeyOzField), '');
      await tester.pumpAndSettle();
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Weight is required'), findsOneWidget);
    });

    testWidgets('when metric value is entered then validation is called', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool onValidateCalled = false;

      when(mockDb.watchSettings()).thenAnswer(
        (_) => Stream.value(createMockSettings(weightUnit: WeightUnits.metric)),
      );

      // Act
      await tester.pumpWidget(
        createWidget(mockDb, 'Weight', 'Weight is required', 0, (_) {}, (
          newValue,
        ) {
          onValidateCalled = true;
          return 'weight validation called';
        }),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(widgetKey), '1');
      await tester.pumpAndSettle();
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('weight validation called'), findsOneWidget);
      expect(onValidateCalled, isTrue);
    });

    testWidgets('when lb value is entered then validation is called', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool onValidateCalled = false;

      when(mockDb.watchSettings()).thenAnswer(
        (_) =>
            Stream.value(createMockSettings(weightUnit: WeightUnits.imperial)),
      );

      // Act
      await tester.pumpWidget(
        createWidget(mockDb, 'Weight', 'Weight is required', 0, (newVal) {}, (
          newValue,
        ) {
          onValidateCalled = true;
          return 'weight validation called';
        }),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(widgetKeyLbField), '1');
      await tester.pumpAndSettle();
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Assert
      expect(
        find.text('weight validation called'),
        findsExactly(2),
      ); // both lb and oz will fail validation
      expect(onValidateCalled, isTrue);
    });

    testWidgets('when oz value is entered then validation is called', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool onValidateCalled = false;

      when(mockDb.watchSettings()).thenAnswer(
        (_) =>
            Stream.value(createMockSettings(weightUnit: WeightUnits.imperial)),
      );

      // Act
      await tester.pumpWidget(
        createWidget(mockDb, 'Weight', 'Weight is required', 0, (_) {}, (
          newValue,
        ) {
          onValidateCalled = true;
          return 'weight validation called';
        }),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(widgetKeyOzField), '1');
      await tester.pumpAndSettle();
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Assert
      expect(
        find.text('weight validation called'),
        findsExactly(2),
      ); // both lb and oz will fail validation
      expect(onValidateCalled, isTrue);
    });

    testWidgets('when invalid metric value is entered then validation fails', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockDb.watchSettings()).thenAnswer(
        (_) => Stream.value(createMockSettings(weightUnit: WeightUnits.metric)),
      );

      // Act
      await tester.pumpWidget(
        createWidget(
          mockDb,
          'Weight',
          'Weight is required',
          0,
          (_) {},
          (_) => null,
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(widgetKey), 'abc');
      await tester.pumpAndSettle();
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Weight is required'), findsOneWidget);
    });

    testWidgets('when invalid lb value is entered then validation fails', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockDb.watchSettings()).thenAnswer(
        (_) =>
            Stream.value(createMockSettings(weightUnit: WeightUnits.imperial)),
      );

      // Act
      await tester.pumpWidget(
        createWidget(
          mockDb,
          'Weight',
          'Weight is required',
          0,
          (newVal) {},
          (_) => null,
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(widgetKeyLbField), 'abc');
      await tester.pumpAndSettle();
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Weight is required'), findsOneWidget);
    });

    testWidgets('when invalid oz value is entered then validation fails', (
      WidgetTester tester,
    ) async {
      // Arrange
      when(mockDb.watchSettings()).thenAnswer(
        (_) =>
            Stream.value(createMockSettings(weightUnit: WeightUnits.imperial)),
      );

      // Act
      await tester.pumpWidget(
        createWidget(
          mockDb,
          'Weight',
          'Weight is required',
          0,
          (_) {},
          (_) => null,
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(widgetKeyOzField), 'abc');
      await tester.pumpAndSettle();
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Weight is required'), findsOneWidget);
    });
  });

  group('PetWeightEntryWidget data conversion', () {
    testWidgets(
      'when entering pounds and oz should convert to metric correctly',
      (WidgetTester tester) async {
        // Arrange
        double? newWeight = 0;
        when(mockDb.watchSettings()).thenAnswer(
          (_) => Stream.value(
            createMockSettings(weightUnit: WeightUnits.imperial),
          ),
        );

        // Act
        await tester.pumpWidget(
          createWidget(mockDb, 'Weight', 'Weight is required', 0, (newVal) {
            newWeight = newVal;
          }, (_) => null),
        );
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(widgetKeyLbField), '2');
        await tester.enterText(find.byKey(widgetKeyOzField), '3.274');
        await tester.pumpAndSettle();

        // Assert
        expect(newWeight?.toStringAsFixed(3), '1.000');
      },
    );

    testWidgets(
      'when viewing imperial should convert 1 kg to 2 pounds 3.274 oz',
      (WidgetTester tester) async {
        // Arrange
        when(mockDb.watchSettings()).thenAnswer(
          (_) => Stream.value(
            createMockSettings(weightUnit: WeightUnits.imperial),
          ),
        );

        // Act
        await tester.pumpWidget(
          createWidget(
            mockDb,
            'Weight',
            'Weight is required',
            1,
            (_) {},
            (_) => null,
          ),
        );
        await tester.pumpAndSettle();

        final lbTextField =
            find.byKey(widgetKeyLbField).evaluate().first.widget as TextFormField;
        final ozTextField =
            find.byKey(widgetKeyOzField).evaluate().first.widget as TextFormField;

        // Assert
        expect(lbTextField.controller!.text, equals('2'));
        expect(ozTextField.controller!.text, equals('3.274'));
      },
    );
  });
}
