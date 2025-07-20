import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:taste_master_app/src/data/models/models.dart';
import 'package:taste_master_app/src/data/models/api/dog/api_image_dog_model.dart';
import 'package:taste_master_app/src/logic/preference_cubit/dog/prefs_dog_cubit.dart';

import 'prefs_dog_cubit_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late MockBox<PrefsDogModel> mockBox;
  late PrefsDogCubit cubit;

  setUp(() {
    mockBox = MockBox<PrefsDogModel>();
    when(mockBox.values).thenReturn([]);
    when(mockBox.keys).thenReturn([]);
    cubit = PrefsDogCubit(mockBox);
  });

  tearDown(() {
    cubit.close();
  });

  final dog = ApiDogModel(
    id: 1,
    name: 'Labrador Retriever',
    bredFor: 'Retrieving',
    breedGroup: 'Sporting',
    lifeSpan: '10 - 12 years',
    temperament: 'Gentle, Intelligent, Outgoing',
    origin: 'Canada',
    referenceImageId: 'B1uW7l5VX',
    image: ApiImageDogModel(
      id: 'Aoj2M3iqH',
      url: 'https://cdn2.thedogapi.com/images/Aoj2M3iqH.jpg',
      width: 800,
      height: 600,
    ),
  );
  final tasteDog = PrefsDogModel(
    id: 'abc',
    tasteId: 'taste1',
    dog: dog,
  );

  group('PrefsDogCubit', () {
    test('initial state is correct', () {
      expect(cubit.state.selectedDog, isNull);
      expect(cubit.state.tasteDogs, isEmpty);
      expect(cubit.state.dogsByTaste, isEmpty);
      expect(cubit.state.isLoading, isFalse);
    });

    blocTest<PrefsDogCubit, PrefsDogState>(
      'selectDog updates selectedDog',
      build: () => cubit,
      act: (c) => c.selectDog(dog),
      expect: () => [
        isA<PrefsDogState>().having((s) => s.selectedDog, 'selectedDog', dog),
      ],
    );

    blocTest<PrefsDogCubit, PrefsDogState>(
      'fetchDogTastes emits tasteDogs and loading states',
      build: () {
        when(mockBox.values).thenReturn([tasteDog]);
        return cubit;
      },
      act: (c) => c.fetchDogTastes(),
      expect: () => [
        isA<PrefsDogState>().having((s) => s.isLoading, 'isLoading', true),
        isA<PrefsDogState>()
            .having((s) => s.tasteDogs, 'tasteDogs', [tasteDog]).having(
                (s) => s.isLoading, 'isLoading', false),
      ],
    );

    blocTest<PrefsDogCubit, PrefsDogState>(
      'getDogByTaste filters dogs by tasteId',
      build: () {
        when(mockBox.values).thenReturn([tasteDog]);
        return cubit;
      },
      act: (c) => c.getDogByTaste('taste1'),
      expect: () => [
        isA<PrefsDogState>().having((s) => s.isLoading, 'isLoading', true),
        isA<PrefsDogState>()
            .having((s) => s.dogsByTaste, 'dogsByTaste', [tasteDog]).having(
                (s) => s.isLoading, 'isLoading', false),
      ],
    );

    test('isDogLiked returns true if dog is in tasteDogs', () {
      when(mockBox.values).thenReturn([tasteDog]);
      cubit.fetchDogTastes();
      final liked = cubit.isDogLiked(1);
      expect(liked, true);
    });

    test('isDogLiked returns false if dogId is null or not found', () {
      expect(cubit.isDogLiked(null), false);
      expect(cubit.isDogLiked(999), false);
    });

    test('saveDogTaste adds dog to box', () {
      cubit.selectDog(dog);
      when(mockBox.values).thenReturn([tasteDog]);
      when(mockBox.add(any)).thenAnswer((_) async => 0);

      cubit.saveDogTaste('taste1');

      verify(mockBox.add(any)).called(1);
      expect(cubit.state.selectedDog, isNull);
    });

    test('removeDogTaste deletes dog from box', () {
      when(mockBox.values).thenReturn([tasteDog]);
      when(mockBox.deleteAt(any)).thenAnswer((_) async {});
      cubit.fetchDogTastes();
      cubit.removeDogTaste(1);

      verify(mockBox.deleteAt(0)).called(1);
    });

    test('removeAllDogByTaste deletes all by tasteId', () {
      when(mockBox.keys).thenReturn([0]);
      when(mockBox.get(0)).thenReturn(tasteDog);
      when(mockBox.deleteAll(any)).thenAnswer((_) async {});
      when(mockBox.values).thenReturn([]);

      cubit.removeAllDogByTaste('taste1');
      verify(mockBox.deleteAll([0])).called(1);
    });
  });
}
