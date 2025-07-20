// test/mocks/mocks.dart
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:taste_master_app/src/data/models/models.dart';
import 'package:taste_master_app/src/logic/preference_cubit/taste/prefs_taste_cubit.dart';

import 'prefs_taste_cubit_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late MockBox<TasteModel> mockBox;

  setUp(() {
    mockBox = MockBox<TasteModel>();
  });

  group('PrefsTasteCubit', () {
    blocTest<PrefsTasteCubit, PrefsTasteState>(
      'emits isLoading true and then a list of tastes when fetchTastes is called',
      build: () {
        when(mockBox.values).thenReturn([
          TasteModel(name: 'My Taste', id: '1'),
          TasteModel(name: 'My Favorite', id: '2'),
        ]);
        return PrefsTasteCubit(tasteBox: mockBox);
      },
      act: (cubit) => cubit.fetchTastes(),
      expect: () => [
        isA<PrefsTasteState>().having((s) => s.isLoading, 'isLoading', true),
        isA<PrefsTasteState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.tastes.length, 'tastes length', 2),
      ],
    );

    blocTest<PrefsTasteCubit, PrefsTasteState>(
      'adds a new taste when addTaste is called',
      build: () {
        when(mockBox.values).thenReturn([]);
        return PrefsTasteCubit(tasteBox: mockBox);
      },
      act: (cubit) {
        when(mockBox.values).thenReturn([
          TasteModel(name: 'New Taste', id: '3'),
        ]);
        cubit.addTaste('New Taste');
      },
      verify: (_) {
        verify(mockBox.add(any)).called(1);
      },
      expect: () => [
        isA<PrefsTasteState>()
            .having((s) => s.tastes.length, 'tastes length', 1),
      ],
    );

    blocTest<PrefsTasteCubit, PrefsTasteState>(
      'removes an existing taste when removeTaste is called',
      build: () {
        when(mockBox.values).thenReturn([
          TasteModel(name: 'Delete Taste', id: '4'),
        ]);
        when(mockBox.deleteAt(any)).thenAnswer((_) async {});
        return PrefsTasteCubit(tasteBox: mockBox);
      },
      act: (cubit) {
        when(mockBox.values).thenReturn([]);
        cubit.removeTaste('4');
      },
      verify: (_) {
        verifyNever(mockBox.deleteAt(any)).called(0);
      },
      expect: () => [
        isA<PrefsTasteState>()
            .having((s) => s.tastes.length, 'tastes length', 0),
      ],
    );
  });
}
